require 'csv'
require './lib/merchantrepository'
require './lib/itemrepository'
require './lib/invoicerepository'

class SalesEngine

  attr_reader :items, :merchants, :invoices

  def initialize(data)
    @items     = data[:items]
    @merchants = data[:merchants]
    @invoices = data[:invoices]
  end

  def self.from_csv(info)
    SalesEngine.new({ :items => "./data/items.csv",
                      :merchants => "./data/merchants.csv",
                      :invoices => './data/invoices.csv'})
  end

  def merchants
    all = []

    csv = CSV.table(@merchants, headers: true, header_converters: :symbol)
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

end
