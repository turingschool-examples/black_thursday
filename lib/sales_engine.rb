require_relative 'items_repository'
require_relative 'merchant_repo'
require_relative 'invoice_repository'
require_relative 'sales_analyst'
require 'csv'

class SalesEngine

  attr_reader :items,
              :merchants,
              :invoices

  def initialize(items, merchants, invoices)
    @items = items
    @merchants = merchants
    @invoices = invoices
  end

  def self.from_csv(csv_hash)
    items = ItemsRepository.new
    merchants = MerchantRepo.new
    invoices = InvoiceRepository.new
    if csv_hash[:items]
      items_filepath = csv_hash[:items]
      csv_items = CSV.open items_filepath,
                        headers: true,
                        header_converters: :symbol,
                        converters: :all
      items.load_items(csv_items)
    end
    if csv_hash[:merchants]
      merchants_filepath = csv_hash[:merchants]
      csv_merchants = CSV.open merchants_filepath,
                        headers: true,
                        header_converters: :symbol
      merchants.load_merchants(csv_merchants)
    end
    if csv_hash[:invoices]
      invoices_filepath = csv_hash[:invoices]
      csv_invoices = CSV.open invoices_filepath,
                        headers: true,
                        header_converters: :symbol
      invoices.load_invoices(csv_invoices)
    end
    new(items, merchants, invoices)
  end

  def analyst
    SalesAnalyst.new(@items, @merchants, @invoices)
  end
end
