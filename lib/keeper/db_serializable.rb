require 'active_support/inflector'

module DatabaseSerializable

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def table_name
      to_s.downcase.pluralize
    end

    def insert(database, task)
      fields = task.instance_variables

      fields_as_rows = fields.map { |field| field[1..-1] }.join ', '
      values_placeholders = [['?'] * fields.length].join ', '

      q = "INSERT INTO #{table_name}(#{fields_as_rows}) " \
          "VALUES(#{values_placeholders});"

      fields_as_values = fields.map do |field|
        task.instance_variable_get(field).to_s
      end

      database.execute q, *fields_as_values
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
