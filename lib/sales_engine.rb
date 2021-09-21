require 'csv'
require 'rspec'
require 'bigdecimal'
require 'bigdecimal/util'
require './lib/merchantrepository'
require './lib/itemrepository'
require './lib/invoicerepository'
require './lib/invoice_item_repo'
require './lib/transactionrepository'
require './lib/customerrepository'
require './lib/sales_analyst'
require './lib/merchant'
require './lib/item'
require './lib/invoice'
require './lib/invoice_item'
require './lib/transaction'
require './lib/customer'

class SalesEngine

  attr_reader :items, :merchants, :invoices, :invoice_items, :transactions, :customers

  def initialize(data)
    @items     = ItemRepository.new(data[:items], self)
    @merchants = MerchantRepository.new(data[:merchants], self)
    @invoices = InvoiceRepository.new(data[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(data[:invoice_items], self)
    @transactions = TransactionRepository.new(data[:transactions], self)
    @customers = CustomerRepository.new(data[:customers], self)
    @analyst = SalesAnalyst.new(@items, @merchants, @invoices, @invoice_items)
  end

  def self.from_csv(info)
    SalesEngine.new(info)
  end

  # def items

  # end

  # def invoices

  # end
  #
  # def invoice_items
  #   all = []
  #
  #   csv = CSV.read(@invoice_items, headers: true, header_converters: :symbol)
  #    csv.map do |row|
  #      all << InvoiceItem.new(row)
  #   end
  #   InvoiceItemRepository.new(all)
  # end
  #
  # def transactions
  #   all = []
  #
  #   csv = CSV.read(@transactions, headers: true, header_converters: :symbol)
  #    csv.map do |row|
  #      all << Transaction.new(row)
  #   end
  #   TransactionRepository.new(all)
  # end
  #
  # def customers
  #   all = []
  #
  #   csv = CSV.read(@customers, headers: true, header_converters: :symbol)
  #    csv.map do |row|
  #      all << Customer.new(row)
  #   end
  #   CustomerRepository.new(all)
  # end
end
