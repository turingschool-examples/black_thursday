class Merchant
  attr_reader :merchant_id, :merchant_name, :merchant_created_at, :merchant_updated_at
  def initialize(merchant, parent)
    @merchant_id = item[:merchant_id]
    @merchant_name = item[:merchant_name]
    @merchant_created_at = item[:merchant_created_at]
    @merchant_updated_at = item[:merchant_updated_at]
    # @parent = parent
  end
end
