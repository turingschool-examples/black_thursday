require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'transaction_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'
require 'pry'

class SalesEngine
  attr_reader :merchant_contents, :item_contents, :invoice_contents,
              :invoice_item_contents, :transaction_contents, :customer_contents

  def initialize(merchant_file, item_file, invoice_file, invoice_item_file, transaction_file, customer_file)
    @merchant_contents = open_csv(merchant_file)
    @item_contents = open_csv(item_file)
    @invoice_contents = open_csv(invoice_file)
    @invoice_item_contents = open_csv(invoice_item_file)
    @transaction_contents = open_csv(transaction_file)
    @customer_contents = open_csv(customer_file)
    @items = ItemRepository.new(self)
    @merchants = MerchantRepository.new(self)
    @invoices = InvoiceRepository.new(self)
    @invoice_items = InvoiceItemRepository.new(self)
    @transactions = TransactionRepository.new(self)
    @customers = CustomerRepository.new(self)
    load_repositories
  end

  def self.from_csv(files_to_parse = {})
    item_file = files_to_parse.fetch(:items)
    merchant_file = files_to_parse.fetch(:merchants)
    invoice_file = files_to_parse.fetch(:invoices)
    invoice_item_file = files_to_parse.fetch(:invoice_items)
    transaction_file = files_to_parse.fetch(:transactions)
    customer_file = files_to_parse.fetch(:customers)
    SalesEngine.new(merchant_file, item_file, invoice_file, invoice_item_file, transaction_file, customer_file)
  end

  def open_csv(file)
    CSV.open file, headers: true, header_converters: :symbol
  end

  def load_repositories
    merchants
    items
    invoices
    invoice_items
    transactions
    customers
  end

  def items
    @items.item(item_contents)
  end

  def merchants
    @merchants.merchant_repo(merchant_contents)
  end

  def invoices
    @invoices.invoice(invoice_contents)
  end

  def invoice_items
    @invoice_items.invoice_item(invoice_item_contents)
  end

  def transactions
    @transactions.transaction(transaction_contents)
  end

  def customers
    @customers.customer(customer_contents)
  end

  def find_items_by_merch_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def find_merchant_by_merch_id(id)
    @merchants.find_by_id(id)
  end

  def find_invoices_by_merch_id(merchant_id)
    @invoices.find_all_by_merchant_id(merchant_id)
  end

end
