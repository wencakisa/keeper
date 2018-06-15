class StringField < Field
  MAX_LENGTH = 100

  attr_reader :max_length

  def initialize(name, allow_null = nil, max_length = MAX_LENGTH)
    super(name, allow_null)

    @max_length = max_length
  end

  def type
    "VARCHAR(#{@max_length})"
  end
end
