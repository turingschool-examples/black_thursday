class General
  attr_reader :id, :attribute
  
  def initialize(data)
    @id = data[:id]
    @attribute = data[:attribute]
  end

  def update(data)
    @attribute = data[:attribute]
  end
end