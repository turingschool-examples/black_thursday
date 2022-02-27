require 'csv'
require 'pry'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'

class SalesEngine
attr_reader :merchants, :items, :invoices
  def initialize(merchants, items, invoices)
    @merchants = MerchantRepository.new(merchants)
    @items = ItemRepository.new(items)
    @invoices = InvoiceRepository.new(invoices)
  end

  def self.from_csv(input)
    merchant_lines = input[:merchants]
    item_lines = input[:items]
    invoice_lines = input[:invoices]
    SalesEngine.new(merchant_lines, item_lines, invoice_lines)
  end

  def analyst
    SalesAnalyst.new(@merchants, @items)
  end
end
