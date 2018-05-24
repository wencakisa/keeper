class Field
  attr_reader :name, :allow_null

  def initialize(name, allow_null)
    @name = name
    @allow_null = allow_null
  end

  def to_s
    "#{@name} #{type} #{'NOT NULL' unless @allow_null}"
  end

  def type
    raise 'You should subclass this class and implement this method.'
  end
end
