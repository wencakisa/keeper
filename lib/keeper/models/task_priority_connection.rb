class TaskPriorityConnection
  include DatabaseSerializable
  include ManyToMany

  attr_reader :task_id, :priority_id

  def initialize(id = nil, task_id, priority_id)
    @id = id
    @task_id = task_id
    @priority_id = priority_id
  end

  def self.database_fields
    %i[task_id priority_id].map { |value| IntegerField.new(value) }
  end
end
