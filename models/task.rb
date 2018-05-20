require_relative '../db_serializable'

class Task
  include DatabaseSerializable

  attr_accessor :status, :priority, :description # , :tags

  def initialize(status, priority, description)
    @status = status
    @priority = priority
    @description = description
    # @tags = tags
  end
end
