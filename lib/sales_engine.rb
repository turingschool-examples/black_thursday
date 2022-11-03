require 'csv'
require_relative 'item'
require_relative 'merchant'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'sales_analyst'
require_relative 'invoice'
require_relative 'invoice_repository'
class SalesEngine

  attr_reader :items,
              :merchants
              # :invoices,
              # :analyst

  def initialize(csv_hash)
    @items = create_item_repo(csv_hash[:items])
    @merchants = create_merchant_repo(csv_hash[:merchants])
    # if (csv_hash.has_key?(:invoices))
    #   @invoices = create_invoice_repo(csv_hash[:invoices])
    # else
    #   @invoices = nil
    # end
    #   @anaylyst = create_analyst(@items, @merchants, @invoices)
  end

  def self.from_csv(csv_hash)
    sales_engine = SalesEngine.new(csv_hash)
  end

  def create_item_repo(item_csv)
    items = []
    contents = CSV.open item_csv, headers: true, header_converters: :symbol
    contents.each do |row|
      items.push(Item.new({:id => row[:id].to_i,
                           :name => row[:name],
                           :description => row[:description],
                           :unit_price => (row[:unit_price].to_d * (10**(-2))),
                           :created_at => row[:created_at],
                           :updated_at => row[:updated_at],
                           :merchant_id => row[:merchant_id].to_i}))
    end
    item_repo = ItemRepository.new(items)
  end

  def create_merchant_repo(merchant_csv)
    merchants = []
    contents = CSV.open merchant_csv, headers: true, header_converters: :symbol
    contents.each do |row|
      merchants.push(Merchant.new({:id => row[:id].to_i,
                                   :name => row[:name]}))
    end
    merchant_repo = MerchantRepository.new(merchants)
  end

  def create_invoice_repo(invoice_csv)
    invoices = []
    contents = CSV.open invoice_csv, headers: true, header_converters: :symbol
    contents.each do |row|
      invoices.push(Invoice.new({:id => row[:id].to_i,
                           :name => row[:name],
                           :description => row[:description],
                           :unit_price => row[:unit_price].to_d,
                           :created_at => row[:created_at],
                           :updated_at => row[:updated_at],
                           :merchant_id => row[:merchant_id].to_i}))
    end
    invoice_repo = InvoiceRepository.new(items)
  end

end
