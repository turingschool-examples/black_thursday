
require_relative "item_repository"
require_relative "merchant_repository"
require "csv"
require 'pry'

class SalesEngine
  attr_reader :items, :merchants

  def from_csv(input_hash)
    item_contents = CSV.open(input_hash[:items]) #headers: true header
    merchant_contents = CSV.open(input_hash[:merchants])
    # output = "#{:id},#{:name},#{:description},#{:unit_price},#{:merchant_id},#{:created_at},#{:updated_at}"
    @items = ItemRepository.new(item_contents)
    @merchants = MerchantRepository.new(merchant_contents)

  end

  {
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
  }
end

#se.merchants
#=> seems to just return your MerchantRepo *object*

#SE will just read csv files and set up Item Repos and Merchant Repos
#- items and merchants initilialized as empty



#!! from_csv is a CLASS INSTANCE
# mod 2-er says to look up '*.self'

#from_csv
# Call class method on SE,
# pass in the paths
# instantiate IR and MR

#.items - returns IR object
#.merchants - returns MR objects
