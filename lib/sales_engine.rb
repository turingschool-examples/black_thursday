# frozen_string_literal: true

require_relative './item_repository'
require_relative './merchant_repository'
require_relative './sales_analyst'
require_relative './fileio'

# allows creation and access to items and merchants
class SalesEngine
  attr_reader :items,
              :merchants,
              :analyst,
              :invoices
  def initialize(paths)
    @items = ItemRepository.new(FileIo.load(paths[:items]))
    @merchants = MerchantRepository.new(FileIo.load(paths[:merchants]))
    @invoices = InvoiceRepository.new(FileIo.load(paths[:invoices]))
    @analyst = SalesAnalyst.new(self)
  end

  def all_items_per_merchant
    @items.all.group_by(&:merchant_id)
  end

  def all_item_prices_per_item
    item_price_per_item = {}
    @items.all.each do |item|
      item_price_per_item[item] = item.unit_price
    end
    item_price_per_item
  end

  def self.from_csv(path)
    SalesEngine.new(path)
  end
end
