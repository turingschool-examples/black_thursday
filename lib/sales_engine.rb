require 'csv'
require 'pry'
require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine
attr_reader :merchants, :items
  def initialize(merchants, items)
    @merchants = MerchantRepository.new(merchants)
    @items = ItemRepository.new(items)
  end

  def self.from_csv(input)
    merchant_lines = input[:merchants]
    item_lines = input[:items]
    SalesEngine.new(merchant_lines, item_lines)
  end
end
