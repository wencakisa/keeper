class TaskTagConnection
  include DatabaseSerializable
  include ManyToMany

  attr_reader :task_id, :tag_id

  def initialize(id = nil, task_id, tag_id)
    @id = id
    @task_id = task_id
    @tag_id = tag_id
  end

  def self.database_fields
    %i[task_id tag_id].map { |value| IntegerField.new(value) }
  end
end
