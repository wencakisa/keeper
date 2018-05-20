require 'sqlite3'

require './db_manager'
require './models/task'

DB_NAME = 'todo.sqlite'.freeze
File.delete(DB_NAME) if File.exist?(DB_NAME)

DATABASE = SQLite3::Database.new DB_NAME

manager = DatabaseManager.instance

q = "CREATE TABLE #{manager.get_table_name Task} (" \
  'id          INTEGER     PRIMARY KEY,' \
  'status      VARCHAR(10) NOT NULL,' \
  'priority    VARCHAR(10) NOT NULL,' \
  'description VARCHAR(50) NOT NULL' \
  ');'

DATABASE.execute(q)

manager.insert DATABASE, Task.new(:todo, :low, 'heiheihei')
manager.insert DATABASE, Task.new(:done, :high, 'daimu')
manager.insert DATABASE, Task.new(:doing, :normal, 'skr')
manager.insert DATABASE, Task.new(:todo, :low, 'otkachai')
manager.insert DATABASE, Task.new(:todo, :high, 'izponarazdai')

result = manager.all DATABASE, Task

result.each do |row|
  puts row.join ', '
end
