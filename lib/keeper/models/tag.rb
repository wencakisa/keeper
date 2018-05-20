require_relative '../db_serializable'

class Tag
  include DatabaseSerializable

  attr_reader :name

  def initialize(name)
    @name = name
  end
end
