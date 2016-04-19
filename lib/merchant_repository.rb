require 'csv'
require 'pry'
require_relative 'merchant'

class MerchantRepository
  attr_accessor :merchants

  def initialize(merchants_data)
    @merchants = merchants_data.map do |merchant_data|
      Merchant.new(merchant_data)
    end
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
      merchant.name == name.downcase
    end
  end
# this will return the array if it matches more than one
# how do we return a fragment if not found in the data
  def find_all_by_name(name)
    names = @merchants.select do |merchant|
      merchant.name.include?(name.downcase)
    end
    names
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
