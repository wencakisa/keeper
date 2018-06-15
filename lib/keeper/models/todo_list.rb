class TodoList
  include DatabaseSerializable

  attr_reader :title

  def initialize(id = nil, title)
    @id = id
    @title = title
  end

  def self.database_fields
    [
      StringField.new(:title)
    ]
  end
end
