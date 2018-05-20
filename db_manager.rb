require 'singleton'
require 'active_support/inflector'

class DatabaseManager
  include Singleton

  def insert(database, task)
    table_name = get_table_name task.class

    fields = task.instance_variables

    fields_as_rows = fields.map { |field| field[1..-1] }.join ', '
    values_placeholders = [['?'] * fields.length].join ', '

    q = "INSERT INTO #{table_name}(#{fields_as_rows}) " \
      "VALUES(#{values_placeholders});"

    fields_as_values = fields.map do |field|
      task.instance_variable_get(field).to_s
    end

    database.execute(q, *fields_as_values)
  end

  def all(database, klass)
    database.execute("SELECT * FROM #{get_table_name klass}")
  end

  def get_table_name(klass)
    klass.to_s.downcase.pluralize
  end
end
