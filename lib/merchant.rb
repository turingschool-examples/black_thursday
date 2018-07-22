class Merchant
  attr_accessor   :name

  attr_reader     :id

  def initialize(merchant_hash)
    @name = merchant_hash[:name]
    @id = merchant_hash[:id]
    @created_at = merchant_hash[:created_at]
    @updated_at = merchant_hash[:updated_at]
  end
end
