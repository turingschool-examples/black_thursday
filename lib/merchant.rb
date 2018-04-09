class Merchant 
  attr_reader :id, :name, :attributes

  def initialize(attributes)
    @attributes = attributes
    @id = attributes[:id]
    @name = attributes[:name]
  end
end