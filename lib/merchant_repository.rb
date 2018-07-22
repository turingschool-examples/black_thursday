require 'csv'
require_relative '../lib/merchant.rb'
require 'pry'

class MerchantRepository
  attr_reader :merchants

  def initialize(merchant_location)
    @merchant_location = merchant_location
    @merchants = []
    from_sales_engine
  end

  def from_sales_engine
    CSV.foreach(@merchant_location, headers: true, header_converters: :symbol) do |row|
      @merchants << Merchant.new(row)
    end
  end

  def all
    @merchants
  end
end
