require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'sales_analyst'
require 'CSV'

class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(args)
    @items = ItemRepository.new(args[:items])#, self)
    @merchants = MerchantRepository.new(args[:merchants])#, self)
  end

  def self.from_csv(args)
    new(args)
  end

  def analyst
    SalesAnalyst.new
  end
end


# item_path = "./data/items.csv"
# merchant_path = "./data/merchants.csv"
# arguments = {
#               :items     => item_path,
#               :merchants => merchant_path,
#             }
# se = SalesEngine.new(arguments)
# require "pry"; binding.pry
