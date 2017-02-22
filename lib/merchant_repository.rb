require './lib/merchant'

class MerchantRepository
  attr_reader :merchant_data

  def initialize(merchant_data)
    @merchant_data = merchant_data
  end


  # def create_merchants(merchant_data)
  #   Merchant.new(merchant_data)
  # end
  def create_merchants
    merchant_data.map do |row|
      Merchant.new(row)
    end
  end

end
