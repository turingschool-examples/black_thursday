class Merchant
  attr_reader :id, :name

  def initialize(data_hash)
    @id = data_hash[:id]
    @name = data_hash[:name]
  end

  def update(attributes)
    @name = attributes[:name]
  end
end
