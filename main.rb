lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'sqlite3'
require 'keeper'

# ------------------------------------------------------------------------------

DB_NAME = 'todo.sqlite'.freeze
File.delete(DB_NAME) if File.exist?(DB_NAME)

DATABASE = SQLite3::Database.new DB_NAME

# ------------------------------------------------------------------------------

[Task, Tag, TaskTagConnection].map { |klass| klass.initialize_table(DATABASE) }

TaskTagConnection.add_index DATABASE, %i[task_id tag_id], true

# ------------------------------------------------------------------------------

task1 = Task.new(:todo, :low, 'heiheihei')
task2 = Task.new(:done, :high, 'daimu')

Task.insert DATABASE, task1
Task.insert DATABASE, task2
Task.insert DATABASE, Task.new(:doing, :normal, 'skr')
Task.insert DATABASE, Task.new(:todo, :low, 'otkachai')
Task.insert DATABASE, Task.new(:todo, :high, 'izponarazdai')

# ------------------------------------------------------------------------------

tag1 = Tag.new(:programming)
tag2 = Tag.new(:school)

Tag.insert DATABASE, tag1
Tag.insert DATABASE, tag2
Tag.insert DATABASE, Tag.new(:meh)

# ------------------------------------------------------------------------------

TaskTagConnection.insert DATABASE, TaskTagConnection.new(task1.id, tag1.id)
TaskTagConnection.insert DATABASE, TaskTagConnection.new(task1.id, tag2.id)
TaskTagConnection.insert DATABASE, TaskTagConnection.new(task2.id, tag2.id)

# ------------------------------------------------------------------------------

puts 'All tasks:'
result = Task.all DATABASE

result.each do |row|
  puts row.join ', '
end

puts 'All tags:'
result = Tag.all DATABASE

result.each do |row|
  puts row.join ', '
end

puts 'Only todo tasks:'
result = Task.find_by DATABASE, :status, :todo
result.each do |row|
  puts row.join ', '
end

puts 'Tags for task 1:'
result = TaskTagConnection.get_related_models DATABASE, task1, Tag
result.each do |row|
  puts row.join ', '
end

puts 'Tasks for tag 2:'
result = TaskTagConnection.get_related_models DATABASE, tag2, Task
result.each do |row|
  puts row.join ', '
end

DATABASE.close
