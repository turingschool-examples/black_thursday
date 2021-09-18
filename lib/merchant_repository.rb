require 'csv'
require './lib/sales_engine'

class MerchantRepository
  attr_reader :all
  def initialize
    @all = []
  end

  # def all
  #   @merchants.map do |merchant|
  #     Merchant.new(merchant[:id], merchant[:name])
  #   end
  # end
end
