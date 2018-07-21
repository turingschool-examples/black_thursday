require 'csv'
require_relative '../lib/merchant.rb'
require 'pry'

class MerchantRepository
  attr_reader :merchants
  
  def initialize(merchant_data)
    @merchant_data = merchant_data
    @merchants = []
    from_sales_engine
  end

  def from_sales_engine
    CSV.foreach(@merchant_data, headers: true, header_converters: :symbol) do |row|
      @merchants << Merchant.new(row)
      # binding.pry
    end
  end

  def all
    @merchants
    # binding.pry
  end
end
