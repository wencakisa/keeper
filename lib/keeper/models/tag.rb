class Tag
  include DatabaseSerializable

  attr_reader :name

  def initialize(id = nil, name)
    @id = id
    @name = name
  end

  def self.table_values
    {
      name: {
        type: 'VARCHAR(10)',
        null: false
      }
    }
  end
end
