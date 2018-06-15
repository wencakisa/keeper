class Priority
  include DatabaseSerializable

  attr_reader :name

  def initialize(id = nil, name)
    @id = id
    @name = name
  end

  def self.database_fields
    [
      StringField.new(:name)
    ]
  end
end
