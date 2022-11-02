require 'csv'
require './lib/merchant_repository'
require './lib/item_repository'
require 'pry'

p 'salesengine'

# puts contents

class SalesEngine
  attr_reader :merchants,
              :items

  def initialize
    @merchants = MerchantRepository.new
    @items = ItemRepository.new
    # clean_csv
    
  end

  def self.from_csv(hash_path)
    new
    #test open instead of read
    contents = CSV.read hash_path[:merchants], headers: true, header_converters: :symbol
    #12334105
    #Shopin1901
    # 2010-12-10
    # 2011-12-04
    #This is information for a single merchant instance
    #We want to take this information and turn into a hash to pash to @merchants.create(attributes)
    contents.to_a[1]
    binding.pry
    names = contents.map do |row|
      name = row[:name]
    end
  end

#   def clean_csv
    #read merchant.csv
    #take the first merchant info
    #make first merchant instance  
  # end
  
    #   id = row[:id]
    # end
end

# contents = CSV.open "./data/merchants.csv", headers: true
# require 'pry'; binding.pry
#

#     # def from_csv
#     # end
# end

# se = SalesEngine.from_csv({
#   :items     => "./data/items.csv",
#   :merchants => "./data/merchants.csv",
# })

# p se
