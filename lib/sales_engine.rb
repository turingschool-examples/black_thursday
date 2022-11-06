require 'csv'
require_relative 'merchant_repository'
require_relative './item_repository'
require_relative './item'
require_relative './merchant'
require_relative './sales_analyst'
require_relative './invoice'
require_relative './invoice_repository'
require_relative 'invoice_item_repository'
require 'pry'

class SalesEngine
  attr_reader :merchants,
              :items,
              :invoices,
              :invoice_items

  def initialize
    @merchants = MerchantRepository.new
    @items = ItemRepository.new
    @invoices = InvoiceRepository.new
    @invoice_items = InvoiceItemRepository.new
  end

  def self.from_csv(hash_path)
    sales_engine = new

    rows = CSV.open hash_path[:invoices], headers: true, header_converters: :symbol
    rows.each do |row|
      new_item = Invoice.new(row.to_h)
      sales_engine.invoices.all << new_item
    end    

    sales_engine.items.parse_data(hash_path[:items])
    sales_engine.merchants.parse_data(hash_path[:merchants])
    # require 'pry'; binding.pry
    sales_engine.invoice_items.parse_data(hash_path[:invoice_items])

    sales_engine
  end

  def analyst
    @analyst = SalesAnalyst.new(self)
    # KR why is analyst an attribute value?
  end
end
