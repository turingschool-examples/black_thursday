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
    @merchant_repository = MerchantRepository.new(self)
    @item_repository = ItemRepository.new(self)
  end

  def merchant_loader(data)
    @merchant_repository.create_merchant(data)
  end

  def item_loader(data)
    @item_repository.create_item(data)
  end

  def self.from_csv(data)
    sales = SalesEngine.new
    sales.item_loader(data)
    sales.merchant_loader(data)
    sales

  end


end
