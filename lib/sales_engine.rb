require 'csv'
require_relative '../lib/items_repository'
require_relative '../lib/merchants_repository'
require_relative '../lib/invoice_items_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/transaction_repository'

class SalesEngine

  def initialize(info)
    @items_lines = (info[:items])
    @merchants_lines = (info[:merchants])
    @invoice_items_lines = info[:invoice_items]
    @invoices_lines = info[:invoices]
    @customers_lines = info[:customers]
    @transactions_lines = info[:transactions]
  end

  def self.from_csv(info)
    SalesEngine.new(info)
  end

  def items
    @items ||= ItemsRepository.new(@items_lines)
  end

  def merchants
    @merchants ||= MerchantsRepository.new(@merchants_lines)
  end

  def invoice_items_repo
    @invoice_items ||= InvoiceItemsRepository.new(@invoice_items_lines)
  end

  def invoices
    @invoices ||= InvoiceRepository.new(@invoices_lines)
  end

  def customers
    @customers ||= CustomerRepository.new(@customers_lines)
  end

  def transactions
    @transactions ||= TransactionRepository.new(@transactions_lines)
  end

  def run
    items
    merchants
    invoice_items_repo
    invoices
    customers
    transactions
  end

  def analyst
    Analyst.new
  end
end #SalesEngine class end
