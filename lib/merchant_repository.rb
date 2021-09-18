require 'csv'
require './lib/sales_engine'

class MerchantRepository
  attr_reader :merchants
  def initialize(data)
    # @all = merchants_array
    @merchants = data[:merchants]
  end

  def merchant(id, merchant_name)
    x = Merchant.new(merchant[:id], merchant[:name])
    require "pry"; binding.pry
  end

  def merchants_array(merchant)
    @merchants = []
    merchants << x
    # @merchants.map do |merchant|

  end
end
