class TaskStatusConnection
  include DatabaseSerializable
  include ManyToMany

  attr_reader :task_id, :status_id

  def initialize(id = nil, task_id, status_id)
    @id = id
    @task_id = task_id
    @status_id = status_id
  end

  def self.database_fields
    %i[task_id status_id].map { |value| IntegerField.new(value) }
  end
end
