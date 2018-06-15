class IntegerField < Field
  def initialize(name, allow_null = nil)
    super(name, allow_null)
  end

  def type
    'INTEGER'
  end
end
