class Task
  include DatabaseSerializable

  attr_accessor :priority_id, :status_id, :description

  def initialize(id = nil, priority_id, status_id, description)
    @id = id
    @priority_id = priority_id
    @status_id = status_id
    @description = description
  end

  def self.database_fields
    [
      IntegerField.new(:priority_id),
      IntegerField.new(:status_id),
      StringField.new(:description, true, 5)
    ]
  end
end
