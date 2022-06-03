class Merchant
  attr_reader :id, :name
  attr_writer :name

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
  end
end
