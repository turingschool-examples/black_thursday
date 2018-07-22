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

  def find_by_id(id_number)
    @merchants.find do |merchant|
      merchant.id == id_number.to_s
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant.name == name
    end
  end

end
