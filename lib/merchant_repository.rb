require 'csv'

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
      merchant.name == name
    end
  end
# this will return the array if it matches more than one
# how do we return a fragment if not found in the data
  def find_all_by_name(name)
    name_array = []
    @merchants.find do |merchant|
      merchant.name == name
      name_array << name
    end
  end

end
