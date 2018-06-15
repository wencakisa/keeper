class UserTodoListConnection
  include DatabaseSerializable
  include ManyToMany

  attr_reader :user_id, :todolist_id

  def initialize(id = nil, user_id, todolist_id)
    @id = id
    @user_id = user_id
    @todolist_id = todolist_id
  end

  def self.database_fields
    %i[user_id todolist_id].map { |value| IntegerField.new(value) }
  end
end
