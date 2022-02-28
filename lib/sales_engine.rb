# sales_engine
require 'CSV'
# require_relative 'item_repository'
require_relative 'merchant_repository'
# require_relative 'invoice_repository'
# require_relative 'item'
require_relative 'merchant'
# require_relative 'invoice'
# require_relative 'sales_analyst'

class SalesEngine
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def self.from_csv(data)
    new(data)
  end

  def merchants
    @merchants ||= MerchantRepository.new(data[:merchants])
  end
end
# def initialize(items_, merchants_, invoices_)
#   @items = ItemRepository.new(items_)
#   @merchants = MerchantRepository.new(merchants_)
#   @invoices = InvoiceRepository.new(invoices_)
# end

# def self.from_csv(csv_hash)
#   item_contents = CSV.open csv_hash[:items], headers: true, header_converters: :symbol
#   merchant_contents = CSV.open csv_hash[:merchants], headers: true, header_converters: :symbol
#   invoice_contents = CSV.open csv_hash[:invoices], headers: true, header_converters: :symbol

#   # read file, create objects, return SE object
#   items = []
#   item_contents.each do |row|
#     items << Item.new(row)
#   end

#   merchants = []
#   merchant_contents.each do |row|
#     merchants << Merchant.new(row)
#   end

#   invoices = []
#   invoice_contents.each do |row|
#     invoices << Invoice.new(row)
#   end

#   se = SalesEngine.new(items, merchants, invoices)
# end

# def analyst
#   SalesAnalyst.new(@items.all, @merchants.all, @invoices.all)
# end
