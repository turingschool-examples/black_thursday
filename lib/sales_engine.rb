require 'csv'
require_relative "../lib/merchant_repository"
require_relative "../lib/item_repository"
require_relative "../lib/invoice_repository"
require_relative "./sales_analyst"


class SalesEngine
  attr_reader :items, :merchants, :invoices, :analyst

  def initialize(items, merchants, invoices = nil)
    @items = ItemRepository.new(populate_items(items))
    @merchants = MerchantRepository.new(populate_merchants(merchants))
    @invoices = InvoiceRepository.new(populate_invoices(invoices))
    @analyst = SalesAnalyst.new(@items, @merchants, @invoices)
  end

  def self.from_csv(info)
    self.new(info[:items], info[:merchants], info[:invoices])
  end

  def populate_invoices(file_path)
    file = CSV.read(file_path, headers: true, header_converters: :symbol)
    file.map do |row|
      Invoice.new(row)
    end
  end

  def populate_merchants(file_path)
    file = CSV.read(file_path, headers: true, header_converters: :symbol )
    file.map do |row|
      Merchant.new(row)
    end
  end

  def populate_items(file_path)
    file = CSV.read(file_path, headers: true, header_converters: :symbol )
    file.map do |row|
      Item.new(row)
    end
  end

end
