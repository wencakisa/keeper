lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'sqlite3'
require 'keeper'

# ------------------------------------------------------------------------------

DB_NAME = 'todo.sqlite'.freeze
File.delete(DB_NAME) if File.exist?(DB_NAME)

DATABASE = SQLite3::Database.new DB_NAME

# ------------------------------------------------------------------------------

[Task, Tag, TaskTagConnection, User, Priority, Status, TaskStatusConnection, TaskPriorityConnection].map { |klass| klass.initialize_table(DATABASE) }
