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

  def from_csv
#     new
#     #test open instead of read
    contents = CSV.open './data/merchants.csv'[:merchants], headers: true, header_converters: :symbol
#   
#     #This is information for a single merchant instance
#     #We want to take this information and turn into a hash to pash to @merchants.create(attributes)
#     contents.to_a[1]
    contents.map do |row|
        binding.pry
      self.create(row)
#     end
  end

#   def clean_csv
    #read merchant.csv
    #take the first merchant info
    #make first merchant instance  
  # end
  
    #   id = row[:id]
    # end
end


end