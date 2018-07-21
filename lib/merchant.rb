class Merchant
  attr_reader :name,
              :id

  def initialize(merchant_hash)
    @merchant_hash = merchant_hash
    @name = merchant_hash[:name]
    @id = merchant_hash[:id]
  end
end
