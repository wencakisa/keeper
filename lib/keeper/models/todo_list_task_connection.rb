class TodoListTaskConnection
  include DatabaseSerializable
  include ManyToMany

  attr_reader :todolist_id, :task_id

  def initialize(id = nil, todolist_id, task_id)
    @id = id
    @todolist_id = todolist_id
    @task_id = task_id
  end

  def self.database_fields
    %i[todolist_id task_id].map { |value| IntegerField.new(value) }
  end
end
