require './config'
require './seeds'

# ----------------------------------------------------------------------------

puts 'All tasks:'
result = Task.all DATABASE
result.each do |row|
  puts row.join ', '
end

# ----------------------------------------------------------------------------

puts '', 'All tags:'
result = Tag.all DATABASE
result.each do |row|
  puts row.join ', '
end

# ----------------------------------------------------------------------------

puts '', 'Only todo tasks:'
result = TaskStatusConnection.get_related_models DATABASE, $statuses[0], Status

result.each do |row|
  puts row.join ', '
end

# ----------------------------------------------------------------------------

puts '', 'Tags for task 1:'
result = TaskTagConnection.get_related_models DATABASE, $tasks[0], Tag
result.each do |row|
  puts row.join ', '
end

# ----------------------------------------------------------------------------

puts '', 'Tasks for tag 2:'
result = TaskTagConnection.get_related_models DATABASE, $tags[1], Task
result.each do |row|
  puts row.join ', '
end

# ----------------------------------------------------------------------------

puts '', 'All Users:'
result = User.all DATABASE
result.each do |row|
  puts row.join ', '
end

# ----------------------------------------------------------------------------

puts '', 'Information for First User'
result = UserTodoListConnection.get_related_models DATABASE, $users[0], User
result.each do |row|
  puts row.join ', '
end

# ----------------------------------------------------------------------------

puts '', 'Information for Second User'
result = UserTodoListConnection.get_related_models DATABASE, $users[1], User
result.each do |row|
  puts row.join ', '
end

# ----------------------------------------------------------------------------

puts '', 'Information for Third User'
result = UserTodoListConnection.get_related_models DATABASE, $users[2], User
result.each do |row|
  puts row.join ', '
end

# ----------------------------------------------------------------------------

puts '', 'Tasks in First TodoList'
result = TodoListTaskConnection.get_related_models DATABASE, $todo_lists[0], TodoList
result.each do |row|
  puts row.join ', '
end

# ----------------------------------------------------------------------------

puts '', 'Tasks in Second TodoList'
result = TodoListTaskConnection.get_related_models DATABASE, $todo_lists[1], TodoList
result.each do |row|
  puts row.join ', '
end

# ----------------------------------------------------------------------------

DATABASE.close
