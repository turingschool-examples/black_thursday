require 'csv'
require './lib/sales_engine'

class MerchantRepository
  def initialize(data)
    @merchants = data
  end

  def all
    @merchants.map do |merchant|
      Merchant.new(merchant[:id], merchant[:name])
    end
  end
end
