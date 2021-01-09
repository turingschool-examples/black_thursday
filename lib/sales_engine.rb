require_relative 'merchant_repository'
require_relative 'item_repository'
require 'csv'

class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(args)
    @items = ItemRepository.new(args[:items], self)
    # @merchants = MerchantRepository.new(args[:merchants])#, self)
  end

  def self.from_csv(args)
    new(args)
  end
end


item_path = "./data/items.csv"
arguments = {:items => item_path}
# se = SalesEngine.new(arguments)
# require "pry"; binding.pry
