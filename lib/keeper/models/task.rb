class Task
  include DatabaseSerializable

  attr_accessor :description

  def initialize(id = nil, description)
    @id = id
    @description = description
  end

  def self.database_fields
    [
      StringField.new(:description, true, 5)
    ]
  end
end
