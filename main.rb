require 'sqlite3'

require './lib/keeper'

DB_NAME = 'todo.sqlite'.freeze
File.delete(DB_NAME) if File.exist?(DB_NAME)

DATABASE = SQLite3::Database.new DB_NAME

q = "CREATE TABLE #{Task.table_name} (" \
  'id          INTEGER     PRIMARY KEY,' \
  'status      VARCHAR(10) NOT NULL,' \
  'priority    VARCHAR(10) NOT NULL,' \
  'description VARCHAR(50) NOT NULL' \
  ');'

DATABASE.execute(q)

Task.insert DATABASE, Task.new(:todo, :low, 'heiheihei')
Task.insert DATABASE, Task.new(:done, :high, 'daimu')
Task.insert DATABASE, Task.new(:doing, :normal, 'skr')
Task.insert DATABASE, Task.new(:todo, :low, 'otkachai')
Task.insert DATABASE, Task.new(:todo, :high, 'izponarazdai')

result = Task.all DATABASE

result.each do |row|
  puts row.join ', '
end

puts 'ONLY TODO TASKS: '
result = Task.find_by DATABASE, :status, :todo
result.each do |row|
  puts row.join ', '
end
