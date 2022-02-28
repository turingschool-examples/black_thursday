require 'csv'
require_relative '../lib/items_repository'
require_relative '../lib/merchants_repository'
require_relative '../lib/invoice_items_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/transaction_repository'

class SalesEngine

  def initialize(info)
    @items = info[:items]
    @merchants = info[:merchants]
    @invoice_items = info[:invoice_items]
    @invoices = info[:invoices]
    @customers = info[:customers]
    @transactions = info[:transactions]
  end

  def self.from_csv(info)
    SalesEngine.new(info)
  end

  def items
    ItemsRepository.new(@items)
  end

  def merchants
    MerchantsRepository.new(@merchants)
  end

  def invoice_items_repo
    InvoiceItemsRepository.new(@invoice_items)
  end

  def invoices
    InvoiceRepository.new(@invoices)
  end

  def customers
    CustomerRepository.new(@customers)
  end

  def transactions
    TransactionRepository.new(@transactions)
  end

  def analyst
    Analyst.new
  end
end #SalesEngine class end
