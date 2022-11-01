class Merchant
  attr_reader :id, :name
  attr_writer :id
  def initialize(attributes)
    @id = attributes[:id]
    @name =attributes[:name]
  end
end
