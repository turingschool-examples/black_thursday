require 'csv'
require_relative './item_repository'
require_relative './merchant_repository'
require_relative './invoice_repository'
require_relative './transaction_repository'
require_relative './customer_repository'
require_relative './invoice_item_repository'
require_relative './engine_readers'

class SalesEngine
  include EngineReaders
  attr_reader :item_file,
              :merchant_file,
              :invoice_file,
              :transaction_file,
              :customer_file,
              :invoice_item_file

  def initialize(repository)
    @items = nil
    @item_file = repository[:items]
    @merchants = nil
    @merchant_file = repository[:merchants]
    @invoices = nil
    @invoice_file = repository[:invoices]
    @transactions = nil
    @transaction_file = repository[:transactions]
    @customers = nil
    @customer_file = repository[:customers]
    @invoice_items = nil
    @invoice_item_file = repository[:invoice_items]
  end

  def self.from_csv(files)
    SalesEngine.new({
      :items => load_csv(files[:items]),
      :merchants => load_csv(files[:merchants]),
      :invoices => load_csv(files[:invoices]),
      :transactions => load_csv(files[:transactions]),
      :customers => load_csv(files[:customers]),
      :invoice_items => load_csv(files[:invoice_items])
    })
  end

  def self.load_csv(file_name)
    CSV.readlines(file_name, headers: true, header_converters: :symbol)
  end

  def find_items_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end

  def find_merchant_by_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def find_all_invoices_by_merchant_id(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end

  def find_items_by_invoice_id(invoice_id)
    current_invoice_items = invoice_items.find_all_by_invoice_id(invoice_id)
    current_invoice_items.map do |item|
      items.find_by_id(item.item_id)
    end
  end

  def find_transaction_by_invoice_id(invoice_id)
    transactions.find_all_by_invoice_id(invoice_id)
  end

  def find_customer_by_id(customer_id)
    customers.find_by_id(customer_id)
  end

  def find_invoice_by_invoice_id(invoice_id)
    invoices.find_by_id(invoice_id)
  end

  def find_all_customers_by_merchant_id(merchant_id)
    recent_invoices = invoices.find_all_by_merchant_id(merchant_id)
    recent_invoices.reduce([]) do |result, invoice|
      customer = customers.find_by_id(invoice.customer_id)
      result << customer if !result.include?(customer)
      result
    end
  end

  def find_merchant_by_customer_id(customer_id)
    recent_invoices = invoices.find_all_by_customer_id(customer_id)
    recent_invoices.reduce([]) do |result, invoice|
      merchant = merchants.find_by_id(invoice.merchant_id)
      result << merchant if !result.include?(merchant)
      result
    end
  end

  def find_invoice_items_by_invoice_id(invoice_id)
    invoice_items.find_all_by_invoice_id(invoice_id)
  end
end
