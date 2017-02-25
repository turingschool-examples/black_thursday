
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
    se.items = ItemRepository.new(data[:items], se)#, self)
    se.merchants = MerchantRepository.new(data[:merchants], se)#, self)
    se
  end
  

    # binding.pry
  # def merchants
  #   @merchants
  # end

  # def items
  #   @items
  # end
  # def self.from_csv(data)
  #   #takes in path to data

  #   # binding.pry
  #   item_contents = CSV.open(data[:items], headers: true, header_converters: :symbol)
  #   merchant_contents = CSV.open(data[:merchants], headers: true, header_converters: :symbol)
    
  #   se = SalesEngine.new
  #   se.items = ItemRepository.new(item_contents)
  #   se.merchants = MerchantRepository.new(merchant_contents)
  #   return se
  # end

end

 se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv" })

# binding.pry

# ""
# #se.merchants

# ir = se.items
# ir.make_items
# binding.pry



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
