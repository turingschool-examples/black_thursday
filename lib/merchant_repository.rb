require './lib/merchant'
require './lib/sales_engine'
require 'csv'

class MerchantRepository
  attr_reader :merchants,
              :path

  def initialize(path)
    @path = path
    @merchants = []
    read_merchant
  end

  def read_merchant
    CSV.foreach(@path, headers: :true , header_converters: :symbol) do |row|
      @merchants << Merchant.new(row)
    end
    return @merchants
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end
end
