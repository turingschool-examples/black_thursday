require 'csv'
require 'rspec'
require 'bigdecimal'
require 'bigdecimal/util'
require 'time'
require_relative 'merchantrepository'
require_relative 'itemrepository'
require_relative 'invoicerepository'
require_relative 'invoice_item_repo'
require_relative 'transactionrepository'
require_relative 'customerrepository'
require_relative 'sales_analyst'
require_relative 'merchant'
require_relative 'item'
require_relative 'invoice'
require_relative 'invoice_item'
require_relative 'transaction'
require_relative 'customer'

class SalesEngine

  attr_reader :items, :merchants, :invoices, :invoice_items, :transactions, :customers

  def initialize(data)
    @items     = ItemRepository.new(data[:items], self)
    @merchants = MerchantRepository.new(data[:merchants], self)
    @invoices = InvoiceRepository.new(data[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(data[:invoice_items], self)
    @transactions = TransactionRepository.new(data[:transactions], self)
    @customers = CustomerRepository.new(data[:customers], self)
    @analyst = SalesAnalyst.new(@items, @merchants, @invoices, @invoice_items, @transactions)
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
