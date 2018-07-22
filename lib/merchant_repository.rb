class MerchantRepository
  def initialize(merchant_data)
    @merchant_rows ||= build_merchant(merchant_data)
    @merchants = @merchant_rows #shops = an array of merchants, might change this name
  end

  def build_merchant(merchant_data)
    merchant_data.map do |merchant|
      Merchant.new(merchant)
    end
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id
    end
  end
end
