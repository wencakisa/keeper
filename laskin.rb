# Laskin's file
require './config'

TaskTagConnection.add_index DATABASE, %i[task_id tag_id], true
TaskPriorityConnection.add_index DATABASE, %i[task_id priority_id], true
TaskStatusConnection.add_index DATABASE, %i[task_id status_id], true
UserTodoListConnection.add_index DATABASE, %i[user_id todolist_id], true
TodoListTaskConnection.add_index DATABASE, %i[todolist_id task_id], true
#------------------------------------------------------------------------------
user1 = User.new('Julion', 17)
user2 = User.new('Lasgo', 17)
user3 = User.new('Venzi', 18)

User.insert DATABASE, user1
User.insert DATABASE, user2
User.insert DATABASE, user3
#------------------------------------------------------------------------------
todolist1 = TodoList.new('School')
todolist2 = TodoList.new('Programming')

TodoList.insert DATABASE, todolist1
TodoList.insert DATABASE, todolist2
#------------------------------------------------------------------------------
status1 = Status.new(:Todo)
status2 = Status.new(:Done)
status3 = Status.new(:Doing)

Status.insert DATABASE, status1
Status.insert DATABASE, status2
Status.insert DATABASE, status3
#-------------------------------------------------------------------------------
priority1 = Priority.new(:High)
priority2 = Priority.new(:Normal)
priority3 = Priority.new(:Low)

Priority.insert DATABASE, priority1
Priority.insert DATABASE, priority2
Priority.insert DATABASE, priority3
#-------------------------------------------------------------------------------
tag1 = Tag.new(:school)
tag2 = Tag.new(:programming)
tag3 = Tag.new(:fun)
tag4 = Tag.new(:sport)

Tag.insert DATABASE, tag1
Tag.insert DATABASE, tag2
Tag.insert DATABASE, tag3
Tag.insert DATABASE, tag4
#-------------------------------------------------------------------------------
task1 = Task.new('learning')
task2 = Task.new('sporting')
task3 = Task.new('funing')
task4 = Task.new('programming')

Task.insert DATABASE, task1
Task.insert DATABASE, task2
Task.insert DATABASE, task3
Task.insert DATABASE, task4
#-------------------------------------------------------------------------------
TaskTagConnection.insert DATABASE, TaskTagConnection.new(task1.id, tag1.id)
TaskTagConnection.insert DATABASE, TaskTagConnection.new(task1.id, tag2.id)
TaskTagConnection.insert DATABASE, TaskTagConnection.new(task2.id, tag4.id)
TaskTagConnection.insert DATABASE, TaskTagConnection.new(task3.id, tag3.id)
TaskTagConnection.insert DATABASE, TaskTagConnection.new(task4.id, tag2.id)
#-------------------------------------------------------------------------------
TaskStatusConnection.insert DATABASE, TaskStatusConnection.new(task1.id, status1.id)
TaskStatusConnection.insert DATABASE, TaskStatusConnection.new(task2.id, status2.id)
TaskStatusConnection.insert DATABASE, TaskStatusConnection.new(task3.id, status3.id)
TaskStatusConnection.insert DATABASE, TaskStatusConnection.new(task4.id, status1.id)
#-------------------------------------------------------------------------------
TaskPriorityConnection.insert DATABASE, TaskPriorityConnection.new(task1.id, priority1.id)
TaskPriorityConnection.insert DATABASE, TaskPriorityConnection.new(task2.id, priority2.id)
TaskPriorityConnection.insert DATABASE, TaskPriorityConnection.new(task3.id, priority3.id)
TaskPriorityConnection.insert DATABASE, TaskPriorityConnection.new(task4.id, priority1.id)
#-------------------------------------------------------------------------------
TodoListTaskConnection.insert DATABASE, TodoListTaskConnection.new(todolist1.id, task1.id)
TodoListTaskConnection.insert DATABASE, TodoListTaskConnection.new(todolist1.id, task2.id)
TodoListTaskConnection.insert DATABASE, TodoListTaskConnection.new(todolist2.id, task3.id)
TodoListTaskConnection.insert DATABASE, TodoListTaskConnection.new(todolist2.id, task4.id)
#-------------------------------------------------------------------------------
UserTodoListConnection.insert DATABASE, UserTodoListConnection.new(user1.id, todolist1.id)
UserTodoListConnection.insert DATABASE, UserTodoListConnection.new(user2.id, todolist1.id)
UserTodoListConnection.insert DATABASE, UserTodoListConnection.new(user3.id, todolist2.id)
UserTodoListConnection.insert DATABASE, UserTodoListConnection.new(user2.id, todolist2.id)
#-------------------------------------------------------------------------------
puts 'All tasks:'
result = Task.all DATABASE

result.each do |row|
  puts row.join ', '
end

puts '','All tags:'
result = Tag.all DATABASE

result.each do |row|
  puts row.join ', '
end

puts '','Only todo tasks:'
result = TaskStatusConnection.get_related_models DATABASE, status1, Status

result.each do |row|
  puts row.join ', '
end

puts '','Only done tasks:'
result = TaskStatusConnection.get_related_models DATABASE, status2, Status

result.each do |row|
  puts row.join ', '
end

puts '','Only doing tasks:'
result = TaskStatusConnection.get_related_models DATABASE, status3, Status

result.each do |row|
  puts row.join ', '
end

puts '','Information for First User'
result = UserTodoListConnection.get_related_models DATABASE, user1, User

result.each do |row|
  puts row.join ', '
end

puts '','Information for Second User'
result = UserTodoListConnection.get_related_models DATABASE, user2, User

result.each do |row|
  puts row.join ', '
end

puts '','Information for Third User'
result = UserTodoListConnection.get_related_models DATABASE, user3, User

result.each do |row|
  puts row.join ', '
end

puts '','Tasks in First TodoList'
result = TodoListTaskConnection.get_related_models DATABASE, todolist1, TodoList

result.each do |row|
  puts row.join ', '
end

puts '','Tasks in Second TodoList'
result = TodoListTaskConnection.get_related_models DATABASE, todolist2, TodoList

result.each do |row|
  puts row.join ', '
end


#-------------------------------------------------------------------------------
DATABASE.close
