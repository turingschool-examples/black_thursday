require 'csv'
require 'rspec'
require_relative './item'
require_relative './merchant'
require_relative './invoice'
require_relative './invoice_item'
require_relative './transaction'
require_relative './item_repository'
require_relative './merchant_repository'
require_relative './item_repository'
require_relative './sales_analyst'
require_relative './merchant_repository'
require_relative './merchant'

class SalesEngine
  
  attr_reader :items, :merchants

  ### from_csv will do '.new' things
  def initialize(hash)
    @items = ItemRepository.new(hash[:items], self)
    @merchants = MerchantRepository.new(hash[:merchants], self)
  end

  def self.from_csv(hash)
    new(hash)
    # items = ItemRepository.create_items(hash[:items]).flatten
    # merchants = MerchantRepository.create_merchants(hash[:merchants]).flatten
    # new(items, merchants)
  end

  def analyst
    SalesAnalyst.new(self)
  end
  
  def find_by_merchant_id(id)
    @merchants.find_by_id(id)
  end

end

##### Leftover notes
    # items_contents = CSV.open(csv_hash[:items], headers: true, header_converters: :symbol)
    # merchants_contents = CSV.open(csv_hash[:merchants], headers: true, header_converters: :symbol)
    # sales_engine = SalesEngine.new(items_contents, merchants_contents)

    # this is just raw data from CSV but we have to use the data to initialize new 
    # merchant repo and item repo objects (lines 6-9)

    # next in the ItemRepo we need to use the data to initialize specific individual item objects
    # by iterating through the item repo collection (which is an array)

    # same thing for MerchantRepo 
    # refer to spec harness for for guidance
    #did we install spec harness?