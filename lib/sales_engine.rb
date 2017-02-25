require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require 'pry'


class SalesEngine
  attr_accessor :items, :merchants, :invoices

  def initialize(file_hash)
    @invoices = InvoiceRepository.new(self, file_hash[:invoices])
    @items = ItemRepository.new(self, file_hash[:items])
    @merchants = MerchantRepository.new(self, file_hash[:merchants])
  end

  def self.from_csv(file_hash)
    SalesEngine.new(file_hash)
  end

  def number_of_merchants
    merchants.count
  end

  def number_of_items
    items.count
  end

  def number_of_items_per_merchant
    total = items.data.group_by(&:merchant_id).values.map(&:count)
  end

  def prices_of_each_item
    total = items.all.map { |item| item.unit_price }
  end

end
