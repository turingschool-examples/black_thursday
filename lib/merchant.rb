class Merchant
  attr_reader :merchant_id, :merchant_name, :merchant_created_at, :merchant_updated_at
  def initialize(merchant, parent)
    @merchant_id = merchant[:merchant_id]
    @merchant_name = merchant[:merchant_name]
    @merchant_created_at = merchant[:merchant_created_at]
    @merchant_updated_at = merchant[:merchant_updated_at]
    # @parent = parent
  end
end
