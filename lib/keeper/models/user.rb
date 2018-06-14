class User
  include DatabaseSerializable
    
  attr_accessor :username, :age

  def initialize(id = nil, username, age)
    @id = id
    @username = username
    @age = age
  end

  def self.database_fields
    [
      StringField.new(:username, false, 16),
      IntegerField.new(:age, true)
    ]
  end
end
