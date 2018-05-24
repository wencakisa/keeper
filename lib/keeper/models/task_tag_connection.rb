class TaskTagConnection
  include DatabaseSerializable
  include ManyToMany

  attr_reader :task_id, :tag_id

  def initialize(id = nil, task_id, tag_id)
    @id = id
    @task_id = task_id
    @tag_id = tag_id
  end

  def self.table_values
    {
      task_id: {
        type: 'INTEGER',
        null: false
      },
      tag_id: {
        type: 'INTEGER',
        null: false
      }
    }
  end
end
