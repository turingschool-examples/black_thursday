require 'csv'
require_relative './lib/sales_engine'

module MerchantRepository

  def initialize(data)
    @merchants = data
  end

  def all
    @merchants.map do |merchant|
      Merchant.new(merchant[:id], merchant[:name])
    end
  end
end
