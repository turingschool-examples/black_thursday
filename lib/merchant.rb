class Merchant
  attr_reader :id, :name
  def initialize(merchant_hash)
    @id = merchant_hash[:id]
    @name = merchant_hash[:name] 
  end
end
