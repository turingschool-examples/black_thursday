require_relative "merchant_repository"
require_relative 'item'
require_relative 'merchant'
require 'csv'
class SalesEngine
  attr_reader :items_array, :merchants_array
  def initialize
  @items_array = []
  @merchants_array = []
  end
  def self.from_csv(files)
    engine = SalesEngine.new
    items = CSV.open(files[:items], headers: true, header_converters: :symbol)
    items.each {|data| engine.items_array << Item.new(data)}
    merchants = CSV.open(files[:merchants], headers: true, header_converters: :symbol)
    merchants.each {|data| engine.merchants_array << Merchant.new(data)}
    engine
  end
  def merchants
    MerchantRepository.new(@merchants_array)
  end
  def items
    ItemRepository.new(@items_array)
  end
end
# require "pry"; binding.pry
