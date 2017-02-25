
require_relative "item_repository"
require_relative "merchant_repository"
require "csv"
require 'pry'

class SalesEngine
  attr_accessor :items, :merchants
  
  def self.from_csv(data)
    #files = hash.each_pair do |key, value|
      # @paths[key] = value
    se = SalesEngine.new
    se.items = ItemRepository.new(data[:items], se)
    se.merchants = MerchantRepository.new(data[:merchants], se)
    se
  end

end

 se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv" })
 ir = se.items
 mr = se.merchants

# binding.pry


# ""






#####
#Notes
#####



  # {
  #   :items     => "./data/items.csv",
  #   :merchants => "./data/merchants.csv",
  # }


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
