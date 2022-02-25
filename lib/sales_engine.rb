require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'sales_analyst'
require 'pry'

class SalesEngine
  attr_accessor :items, :merchants, :hash
  def initialize(items, merchants)
    @items = items
    @merchants = merchants
  end

  def self.from_csv(info)
    @items = ItemRepository.new(info[:items])
    @merchants = MerchantRepository.new(info[:merchants])
    new(@items, @merchants)
  end

  def analyst
    SalesAnalyst.new(@merchants, @items)
  end


end
