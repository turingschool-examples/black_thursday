# sales_engine
require 'CSV'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'item'
require_relative 'merchant'
require_relative 'invoice'
require_relative 'sales_analyst'
require_relative 'customer'
require_relative 'customer_repository'

class SalesEngine
  attr_reader :items, :merchants, :invoices, :customers

  def initialize(items_, merchants_, invoices_, customers)
    @items = ItemRepository.new(items_)
    @merchants = MerchantRepository.new(merchants_)
    @invoices = InvoiceRepository.new(invoices_)
    @customers = CustomerRepository.new(customers)
  end

  def self.from_csv(csv_hash)
    item_contents = CSV.open csv_hash[:items], headers: true, header_converters: :symbol
    merchant_contents = CSV.open csv_hash[:merchants], headers: true, header_converters: :symbol
    invoice_contents = CSV.open csv_hash[:invoices], headers: true, header_converters: :symbol
    customer_contents = CSV.open csv_hash[:customers], headers: true, header_converters: :symbol
    # read file, create objects, return SE object
    items = []
    item_contents.each do |row|
      items << Item.new(row)
    end

    merchants = []
    merchant_contents.each do |row|
      merchants << Merchant.new(row)
    end

    invoices = []
    invoice_contents.each do |row|
      invoices << Invoice.new(row)
    end

    customers = []
    customer_contents.each do |row|
      customers << Customer.new(row)
    end

    se = SalesEngine.new(items, merchants, invoices, customers)
    # assign_items_to_merchant
  end

  def analyst
    SalesAnalyst.new(@items.all, @merchants.all, @invoices.all)
  end


end
