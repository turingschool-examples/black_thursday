require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine
  attr_reader :item_repository,
              :from_csv,
              :merchant_repository,
              :items,
              :merchants,
              :merchant_loader,
              :items_store

  def initialize
    @merchants= MerchantRepository.new(self)
    @items = ItemRepository.new(self)
  end

  def merchant_loader(data)
    @merchants.create_merchant(data)
  end

  def item_loader(data)
    @items.create_item(data)
  end

  def self.from_csv(data)
    sales = SalesEngine.new
    sales.item_loader(data)
    sales.merchant_loader(data)
    sales

  end


end
