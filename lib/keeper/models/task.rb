class Task
  include DatabaseSerializable

  attr_accessor :status, :priority, :description

  def initialize(id = nil, status, priority, description)
    @id = id
    @status = status
    @priority = priority
    @description = description
  end

  def self.database_fields
    [
      StringField.new(:status, false, 10),
      StringField.new(:priority, false, 10),
      StringField.new(:description, true, 5)
    ]
  end
end
