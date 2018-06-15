class UserTodoListConnection
  include DatabaseSerializable
  include ManyToMany

  attr_reader :user_id, :todo_list_id

  def initialize(id = nil, user_id, todo_list_id)
    @id = id
    @user_id = user_id
    @todo_list_id = todo_list_id
  end

  def self.database_fields
    %i[user_id todo_list_id].map { |value| IntegerField.new(value) }
  end
end
