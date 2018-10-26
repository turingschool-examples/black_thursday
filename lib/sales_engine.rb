require 'csv'
require_relative "../lib/merchant_repository"
require_relative "../lib/item_repository"
require_relative "../lib/invoice_repository"
require_relative "./sales_analyst"


class SalesEngine
  attr_reader :items, :merchants, :invoices, :analyst

  def initialize(items, merchants, invoices)
    @items = ItemRepository.new(items)
    @merchants = MerchantRepository.new(merchants)
    @invoices = InvoiceRepository.new(populate_invoices(invoices))   #InvoiceRepository.new(invoices)
    @analyst = SalesAnalyst.new(self)
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


end
