require './lib/merchant'
require 'CSV'

class MerchantRepo
  attr_reader :all

  def initialize
    @merchants = []
  end

  def populate_information
    merchants = Hash.new{|h, k| h[k] = [] }
    CSV.foreach('./data/merchants.csv', headers: true, header_converters: :symbol) do |merchant_info|
      merchants[merchant_info[:id]] = Merchant.new(merchant_info)
    end
    merchants.each_value do |merchant|
      @merchants << merchant
    end
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id
      merchant
    end
  end

  def add_merchant(merchant) #helper method for merchant class (later, add new merchant)
    @merchants << merchant
  end

end

# all - returns an array of all known Merchant instances X
# find_by_id(id) - returns either nil or an instance of Merchant with a matching ID X
# find_by_name(name) - returns either nil or an instance of Merchant having done a case insensitive search
# find_all_by_name(name) - returns either [] or one or more matches which contain the supplied name fragment, case insensitive
# create(attributes) - create a new Merchant instance with the provided attributes. The new Merchant’s id should be the current highest Merchant id plus 1.
# update(id, attributes) - update the Merchant instance with the corresponding id with the provided attributes. Only the merchant’s name attribute can be updated.
# delete(id) - delete the Merchant instance with the corresponding id
