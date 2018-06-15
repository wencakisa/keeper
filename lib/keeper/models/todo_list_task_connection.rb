class TodoListTaskConnection
  include DatabaseSerializable
  include ManyToMany

  attr_reader :todo_list_id, :task_id

  def initialize(id = nil, todo_list_id, task_id)
    @id = id
    @todo_list_id = todo_list_id
    @task_id = task_id
  end

  def self.database_fields
    %i[todo_list_id task_id].map { |value| IntegerField.new(value) }
  end
end
