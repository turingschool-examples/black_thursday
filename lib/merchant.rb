class Merchant
  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
  end

  def id
    attributes[:id]
  end

  def name
    attributes[:name]
  end

end
