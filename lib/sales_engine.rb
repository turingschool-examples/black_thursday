require_relative 'merchant_repo'
require_relative 'item_repo'
require_relative 'invoice_repo'
require_relative 'invoice_item_repo'
require_relative 'transaction_repo'
require_relative 'customer_repo'
require 'pry'
require 'csv'

class SalesEngine
  attr_reader :items, :merchants, :invoices, :invoice_items, :transactions, :customers

  def initialize(se_hash)
    @items         = ItemRepository.new(se_hash[:items], self)
    @merchants     = MerchantRepository.new(se_hash[:merchants], self)
    @invoices      = InvoiceRepository.new(se_hash[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(se_hash[:invoice_items], self)
    @transactions  = TransactionRepository.new(se_hash[:transactions], self)
    @customers     = CustomerRepository.new(se_hash[:customers], self)
  end

  def find_items_by_merchant_id(merchant_id)
    @items.find_all_items_to_a_merchant(merchant_id)
  end

  def find_merchant_by_id(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

  def find_invoices_by_merchant_id(merchant_id)
    @invoices.find_all_by_merchant_id(merchant_id)
  end

  def item_ids_by_invoice_id(invoice_id)
    @invoice_items.item_ids_by_invoice_id(invoice_id)
  end

  def find_all_items_by_invoice_id(invoice_id)
    item_ids = item_ids_by_invoice_id(invoice_id)
    items.find_all_items(item_ids)
  end

  def find_transactions_by_invoice_id(invoice_id)
    @transactions.find_all_by_invoice_id(invoice_id)
  end

  def find_invoices_by_transaction(invoice_id)
    @invoices.find_by_id(invoice_id)
  end

  def find_customers_by_invoice(customer_id)
    @customers.find_by_id(customer_id)
  end

  def find_merchants_ids_by_customer_id(customer_id)
    @invoices.find_merchants_ids_by_customer_id(customer_id)
  end

  def find_merchants_by_customer_id(customer_id)
    merchants_ids = find_merchants_ids_by_customer_id(customer_id)
    @merchants.find_matching_merchants(merchants_ids)
  end

  def find_customer_ids_by_merchant_id(merchant_id)
    @invoices.find_customer_ids_by_merchant_id(merchant_id)
  end

  def find_customers_by_merchant_id(merchant_id)
    customer_ids = find_customer_ids_by_merchant_id(merchant_id)
    @customers.find_merchants_by_customer_id(customer_ids)
  end

  def self.from_csv(se_hash)
    merchant_data     = load_merchants(se_hash[:merchants])
    item_data         = load_items(se_hash[:items])
    invoice_data      = load_invoices(se_hash[:invoices])
    invoice_item_data = load_invoice_items(se_hash[:invoice_items])
    transaction_data  = load_transactions(se_hash[:transactions])
    customer_data     = load_customers(se_hash[:customers])

    SalesEngine.new({:items => item_data, :merchants => merchant_data,
                     :invoices => invoice_data, :invoice_items => invoice_item_data,
                     :transactions => transaction_data, :customers => customer_data})
  end

  def self.load_merchants(csvfile)
    CSV.open csvfile, headers: true, header_converters: :symbol
  end

  def self.load_items(csvfile)
    CSV.open csvfile, headers: true, header_converters: :symbol
  end

  def self.load_invoices(csvfile)
    CSV.open csvfile, headers: true, header_converters: :symbol
  end

  def self.load_invoice_items(csvfile)
    CSV.open csvfile, headers: true, header_converters: :symbol
  end

  def self.load_transactions(csvfile)
    CSV.open csvfile, headers: true, header_converters: :symbol
  end

  def self.load_customers(csvfile)
    CSV.open csvfile, headers: true, header_converters: :symbol
  end

end
