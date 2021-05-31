class Merchant
  attr_reader :id, :name

  attr_writer :name

  def initialize(data_hash)
    @id = data_hash[:id]
    @name = data_hash[:name]
  end
end
