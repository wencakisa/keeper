require 'active_support/inflector'

module DatabaseSerializable
  def self.included(base)
    attr_accessor :id
    base.extend ClassMethods
  end

  def valid_instance_variables
    instance_variables.reject { |var| instance_variable_get(var).nil? }
  end

  module ClassMethods
    def table_name
      to_s[0].upcase + to_s[1..-1].downcase.pluralize
    end

    def initialize_table(database)
      q = "CREATE TABLE #{table_name} (" \
            'id INTEGER PRIMARY KEY,' \
            "#{database_fields.map(&:to_s).join ', '}" \
          ');'

      database.execute q
    end

    def insert(database, entry)
      fields = entry.valid_instance_variables

      fields_as_rows = fields.map { |field| field[1..-1] }.join ', '
      values_placeholders = [['?'] * fields.length].join ', '

      q = "INSERT INTO #{table_name}(#{fields_as_rows}) " \
          "VALUES(#{values_placeholders});"

      fields_as_values = fields.map do |field|
        entry.instance_variable_get(field).to_s
      end

      database.execute q, *fields_as_values

      entry.id = database.last_insert_row_id
    end

    def add_index(database, fields, unique = false)
      fields_as_placeholders = fields.map(&:to_s).join ', '

      q = "CREATE#{' UNIQUE' if unique} INDEX IF NOT EXISTS " \
          "#{table_name}_index ON #{table_name}(#{fields_as_placeholders});"

      database.execute q
    end

    def find_by(database, field_name, field_value)
      database.execute all_query + " WHERE #{field_name} = \"#{field_value}\";"
    end

    def all(database)
      database.execute all_query + ';'
    end

    private

    def all_query
      "SELECT * FROM #{table_name}"
    end
  end
end
