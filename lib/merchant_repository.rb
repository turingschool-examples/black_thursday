require './lib/sales_engine'

class MerchantRepository
  attr_reader :merchant_data

  def initialize(merchant_data)
    @merchant_data = merchant_data
  end

  def create_merchants(merchant_data)
    binding.pry
    merchant_data.each do |row|
      row[:id] 
      Merchant.new(row)
    end
  end

end
