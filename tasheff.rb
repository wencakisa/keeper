require './config'

TaskTagConnection.add_index DATABASE, %i[task_id tag_id], true
TaskPriorityConnection.add_index DATABASE, %i[task_id priority_id], true
TaskStatusConnection.add_index DATABASE, %i[task_id status_id], true

# ------------------------------------------------------------------------------

task1 = Task.new('heiheihei')
task2 = Task.new('daimu')

Task.insert DATABASE, task1
Task.insert DATABASE, task2
Task.insert DATABASE, Task.new('skr')
Task.insert DATABASE, Task.new('otkachai')
Task.insert DATABASE, Task.new('izponarazdai')

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
status1 = Status.new(:Todo)
status2 = Status.new(:Done)
status3 = Status.new(:Doing)

Status.insert DATABASE, status1
Status.insert DATABASE, status2
Status.insert DATABASE, status3
#-------------------------------------------------------------------------------

TaskStatusConnection.insert DATABASE, TaskStatusConnection.new(task1.id, status1.id)
TaskStatusConnection.insert DATABASE, TaskStatusConnection.new(task2.id, status2.id)

#-------------------------------------------------------------------------------
priority1 = Priority.new(:High)
priority2 = Priority.new(:Normal)
priority3 = Priority.new(:Low)

Priority.insert DATABASE, priority1
Priority.insert DATABASE, priority2
Priority.insert DATABASE, priority3
#-------------------------------------------------------------------------------
TaskPriorityConnection.insert DATABASE, TaskPriorityConnection.new(task1.id, priority1.id)
TaskPriorityConnection.insert DATABASE, TaskPriorityConnection.new(task2.id, priority2.id)
#-------------------------------------------------------------------------------

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
result = TaskStatusConnection.get_related_models DATABASE, status1, Status

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
