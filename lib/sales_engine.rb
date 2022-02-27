require 'csv'
require 'pry'
require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine
attr_reader :merchants, :items, :invoice_items
  def initialize(merchants, items, invoice_items)
    @merchants = MerchantRepository.new(merchants)
    @items = ItemRepository.new(items)
    @invoice_items = InvoiceItemRepository.new(invoice_items)
  end

  def self.from_csv(input)
    merchant_lines = input[:merchants]
    item_lines = input[:items]
    invoice_item_lines = input[:invoice_items]

    SalesEngine.new(merchant_lines, item_lines, invoice_item_lines)
  end

  def analyst
    SalesAnalyst.new(@merchants, @items)
  end
end
