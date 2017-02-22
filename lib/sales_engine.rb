
require_relative "item_repository"
require "csv"

class SalesEngine
  attr_reader :items, :merchants

  def from_csv(input_hash)
    # contents = CSV.open "data/items.csv"       #headers: true, header_converters: :symbol
    # output = "#{:id},#{:name},#{:description},#{:unit_price},#{:merchant_id},#{:created_at},#{:updated_at}"

    @items = ItemRepository.new
    
  end


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