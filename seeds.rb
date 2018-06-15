require './config'

# -------------------------------------------------------------------

$tasks = ['do the dishes', 'go to dancing classes']
        .map  { |description| Task.new description }
        .each { |task| Task.insert DATABASE, task }

# -------------------------------------------------------------------

$tags = [:home, :hobby, :sports]
       .map  { |title| Tag.new title }
       .each { |tag| Tag.insert DATABASE, tag }

# -------------------------------------------------------------------

$statuses = [:todo, :doing, :done]
           .map  { |title| Status.new title }
           .each { |status| Status.insert DATABASE, status }


# -------------------------------------------------------------------

$priorities = [:low, :normal, :high]
             .map  { |title| Priority.new title }
             .each { |priority| Priority.insert DATABASE, priority }

# -------------------------------------------------------------------

$users = [['July', 17], ['Venzy', 18], ['Lasko', 17]]
         .map  { |user_info| User.new *user_info }
         .each { |user| User.insert DATABASE, user }

# -------------------------------------------------------------------

$todo_lists = $users
              .map  { |user| TodoList.new "#{user.username}'s List" }
              .each { |todo_list| TodoList.insert DATABASE, todo_list }

# -------------------------------------------------------------------

TaskTagConnection.add_index      DATABASE, %i[task_id tag_id],       true
TaskStatusConnection.add_index   DATABASE, %i[task_id status_id],    true
TaskPriorityConnection.add_index DATABASE, %i[task_id priority_id],  true
UserTodoListConnection.add_index DATABASE, %i[user_id todolist_id], true
TodoListTaskConnection.add_index DATABASE, %i[todolist_id task_id], true

# -------------------------------------------------------------------

TaskTagConnection.insert DATABASE, TaskTagConnection.new($tasks[0].id, $tags[0].id)
TaskTagConnection.insert DATABASE, TaskTagConnection.new($tasks[1].id, $tags[1].id)
TaskTagConnection.insert DATABASE, TaskTagConnection.new($tasks[1].id, $tags[2].id)

# -------------------------------------------------------------------

TaskStatusConnection.insert DATABASE, TaskStatusConnection.new($tasks[0].id, $statuses[0].id)
TaskStatusConnection.insert DATABASE, TaskStatusConnection.new($tasks[1].id, $statuses[2].id)

# -------------------------------------------------------------------

TaskPriorityConnection.insert DATABASE, TaskPriorityConnection.new($tasks[0].id, $priorities[1].id)
TaskPriorityConnection.insert DATABASE, TaskPriorityConnection.new($tasks[1].id, $priorities[2].id)

# -------------------------------------------------------------------

TodoListTaskConnection.insert DATABASE, TodoListTaskConnection.new($todo_lists[0].id, $tasks[0].id)
TodoListTaskConnection.insert DATABASE, TodoListTaskConnection.new($todo_lists[0].id, $tasks[1].id)
TodoListTaskConnection.insert DATABASE, TodoListTaskConnection.new($todo_lists[1].id, $tasks[0].id)
TodoListTaskConnection.insert DATABASE, TodoListTaskConnection.new($todo_lists[1].id, $tasks[1].id)
TodoListTaskConnection.insert DATABASE, TodoListTaskConnection.new($todo_lists[2].id, $tasks[0].id)
TodoListTaskConnection.insert DATABASE, TodoListTaskConnection.new($todo_lists[2].id, $tasks[1].id)

#-------------------------------------------------------------------------------

UserTodoListConnection.insert DATABASE, UserTodoListConnection.new($users[0].id, $todo_lists[0].id)
UserTodoListConnection.insert DATABASE, UserTodoListConnection.new($users[1].id, $todo_lists[1].id)
UserTodoListConnection.insert DATABASE, UserTodoListConnection.new($users[2].id, $todo_lists[2].id)

#-------------------------------------------------------------------------------

