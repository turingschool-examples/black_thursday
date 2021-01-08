require_relative 'merchant_repository'
require_relative 'item_repository'
require 'csv'

class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(args)
    @items = ItemRepository.new(args[:items])#, self)
    @merchants = MerchantRepository.new(args[:merchants])#, self)
  end

  def self.from_csv(args)
    new(args)
  #   args.each do |key, filepath|
  #     if key == :items
  #       @item_repository = ItemRepository.new(filepath)
  #     else key == :merchants
  #       @merchant_repository = MerchantRepository.new(filepath)
  #     end
  #   end
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
