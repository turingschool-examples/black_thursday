require 'CSV'
require '/Users/bfl3tch/turing/mod_1/black_thursday/lib/merchant_repository.rb'
require '/Users/bfl3tch/turing/mod_1/black_thursday/lib/item_repository.rb'

# require_relative '../lib/merchant_respository.rb' #generally not recommended

class SalesEngine
  attr_reader :items, :merchants

  def initialize(file_locations)
    #use TDD to progress now that we have an idea of structure
    #follow error messages

    @items = ItemRepository.new(file_locations[:items])
    @merchants = MerchantRepository.new(file_locations[:merchants])
    #argument is the file path with the key designating location

  end

  def self.from_csv(file_locations) #class method, do not require
    #instantiation before running
    #run on the class itself, not an INSTANCE of the class
    SalesEngine.new(file_locations)
  end


end
