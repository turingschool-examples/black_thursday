require 'csv'
require_relative './merchant_repository'
require_relative './item_repository'
class SalesEngine
  attr_reader :item_repository,
              :merchant_repository
  def initialize(args)
    @item_repository = ItemRepository.new(args[:items])
    @merchant_repository = MerchantRepository.new(args[:merchants])
  end
end

  # def from_csv(args)
  #   args.each do |key, value|
  #     if key == :items
  #       @item_repository = Item_repository.new(value)
  #     else key == :merchants
  #       @merchant_repository = MerchantRepository.new(value)
  #     end
  #   end
  # end

item_path = "./data/items.csv"
merchant_path = "./data/merchants.csv"
arguments = {
              :items     => item_path,
              :merchants => merchant_path,
            }
# se = SalesEngine.new(arguments)
# require "pry"; binding.pry
