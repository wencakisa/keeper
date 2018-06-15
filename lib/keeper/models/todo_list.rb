class TodoList
  include DatabaseSerializable

  attr_reader :title

  def initialize(id = nil, user_id, title)
    @id = id
    @user_id = user_id
    @title = title
  end

  def self.database_fields
    [
      IntegerField.new(:user_id),
      StringField.new(:title)
    ]
  end
end
