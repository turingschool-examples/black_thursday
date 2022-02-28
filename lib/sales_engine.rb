require_relative "merchant_repository"
require_relative 'item_repository'
require_relative 'item'
require_relative 'merchant'
require_relative 'sales_analyst'
require_relative 'invoice'
require_relative 'invoice_repository'
require_relative 'invoice_item'
require_relative 'invoice_item_repository'
require_relative 'customers'
require_relative 'customer_repository'
require_relative 'transaction'

require 'csv'

class SalesEngine
  attr_reader :items_array, :merchants_array, :invoices_array, :invoice_items_array, :customers_array, :transactions_array
  def initialize
    @items_array = []
    @merchants_array = []
    @invoices_array = []
    @invoice_items_array = []
    @customers_array = []
    @transactions_array = []
    # @files = files
  end
  def self.from_csv(files)
    engine = SalesEngine.new
    items = CSV.read(files[:items], headers: true, header_converters: :symbol)
    items.each {|data| engine.items_array << Item.new(data)}
    merchants = CSV.read(files[:merchants], headers: true, header_converters: :symbol)
    merchants.each {|data| engine.merchants_array << Merchant.new(data)}
    invoices = CSV.read(files[:invoices], headers: true, header_converters: :symbol)
    invoices.each {|data| engine.invoices_array << Invoice.new(data)}
    invoice_items = CSV.read(files[:invoice_items], headers: true, header_converters: :symbol)
    invoice_items.each {|data| engine.invoice_items_array << InvoiceItem.new(data)}
    customers = CSV.read(files[:customers], headers: true, header_converters: :symbol)
    customers.each {|data| engine.customers_array << Customer.new(data)}
    transactions = CSV.read(files[:transactions], headers: true, header_converters: :symbol)
    transactions.each {|data| engine.transactions_array << Transaction.new(data)}
    engine
    # engine = SalesEngine.new(files)
    # engine.files.each do |filename, filepath|
    #   engine.file_reader(filepath, filename)
    # end
    # engine
  end
  def merchants
    MerchantRepository.new(@merchants_array)
  end
  def items
    ItemRepository.new(@items_array)
  end

  def invoices
    InvoiceRepository.new(@invoice_array)
  end
  def invoice_items
    InvoiceItemRepository.new(@invoice_items_array)
  end
  def customers
    CustomerRepository.new(@customer_array)
  end
  def transactions
    TransactionRepository.new(@transaction_array)
  end
  # def file_reader(filepath, key)
  #   reader = CSV.open(filepath, headers: true, header_converters: :symbol)
  #   reader.each {|data| instantiator(key, data)}
  # end
  # def key_converter(key)
  #   {items: {array: @items_array, klass: Item},
  #    merchants: {array: @merchants_array, klass: Merchant},
  #    invoices: {array: @invoice_array, klass: Invoice},
  #    invoice_items: {array: @invoice_item_array, klass: InvoiceItem},
  #    customers: {array: @customer_array, klass: Customer},
  #    transactions: {array: @transaction_array, klass: Transaction}
  #    }[key]
  # end
  # def instantiator(key, data)
  #   key_converter(key)[:array] << key_converter(key)[:klass].new(data)
  # end

  def analyst
    SalesAnalyst.new
  end
end
require "pry"; binding.pry
