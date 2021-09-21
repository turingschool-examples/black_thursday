require 'csv'
require_relative 'merchantrepository'
require_relative 'itemrepository'
require_relative 'invoicerepository'
require_relative 'invoice_item_repo'

class SalesEngine

  attr_reader :items, :merchants, :invoices, :invoice_items

  def initialize(data)
    @items     = data[:items]
    @merchants = data[:merchants]
    @invoices = data[:invoices]
    @invoice_items = data[:invoice_items]
  end

  def self.from_csv(info)
    SalesEngine.new(info)
  #   SalesEngine.new({ :items => "./data/items.csv",
  #                     :merchants => "./data/merchants.csv",
  #                     :invoices => './data/invoices.csv',
  #                     :invoice_items => './data/invoice_items.csv'})
  end

  def merchants
    all = []

    csv = CSV.read(@merchants, headers: true, header_converters: :symbol)
     csv.map do |row|
       all << Merchant.new(row)
    end
   MerchantRepository.new(all)
  end

  def items
    all = []

    csv = CSV.read(@items, headers: true, header_converters: :symbol)
     csv.map do |row|
       all << Item.new(row)
    end
    ItemRepository.new(all)
  end

  def invoices
    all = []

    csv = CSV.read(@invoices, headers: true, header_converters: :symbol)
     csv.map do |row|
       all << Invoice.new(row)
    end
    InvoiceRepository.new(all)
  end

  def invoice_items
    all = []

    csv = CSV.read(@invoice_items, headers: true, header_converters: :symbol)
     csv.map do |row|
       all << InvoiceItem.new(row)
    end
    InvoiceItemRepository.new(all)
  end
end
