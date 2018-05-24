class Task
  include DatabaseSerializable

  attr_accessor :status, :priority, :description

  def initialize(id = nil, status, priority, description)
    @id = id
    @status = status
    @priority = priority
    @description = description
  end

  def self.table_values
    {
      status: {
        type: 'VARCHAR(10)',
        null: false
      },
      priority: {
        type: 'VARCHAR(10)',
        null: false
      },
      description: {
        type: 'VARCHAR(50)',
        null: false
      }
    }
  end
end
