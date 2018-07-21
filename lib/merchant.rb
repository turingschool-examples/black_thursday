class Merchant
  attr_reader :name,
              :id

  def initialize(merchant_hash)
    @merchant_hash = merchant_hash
    @name = merchant_hash[:name]
    @id = merchant_hash[:id]
    @created_at = merchant_hash[:created_at]
    @updated_at = merchant_hash[:updated_at]
  end
end
