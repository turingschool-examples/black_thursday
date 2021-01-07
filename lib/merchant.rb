class Merchant
  attr_reader :id,
              :name
  def initialize(id, name) #parent)
    @id = id.to_i
    @name = name
    #@parent = parent
  end

  def update(name)
    @name = name
  end

end
