class MerchantRepository

  def initialize(merchant_data)
    @merchant_rows ||= build_merchant(merchant_data)
    @shops = @merchant_rows
  end

  def build_merchant(merchant_data)
    merchant_data.map do |merchant|
      Merchant.new(merchant)
    end
  end

  def all
    @shops
  end
end
