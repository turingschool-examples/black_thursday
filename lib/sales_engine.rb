require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'transaction_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'
require 'pry'

class SalesEngine
  attr_reader :item_csv_path,
              :merchant_csv_path,
              :invoice_csv_path,
              :items,
              :merchants,
              :invoices,
              :transactions,
              :invoice_items,
              :customers

  def initialize(hash)
    get_csv_paths(hash)
    @items = ItemRepository.new(@item_csv_path, self)
    @merchants = MerchantRepository.new(@merchant_csv_path, self)
    @invoices = InvoiceRepository.new(@invoice_csv_path, self)
    @transactions = TransactionRepository.new(@transaction_csv_path, self)
    @invoice_items = InvoiceItemRepository.new(@invoice_items_csv_path, self)
    @customers = CustomerRepository.new(@customer_csv_path, self)
  end

  def get_csv_paths(hash)
    @item_csv_path = hash[:items]
    @merchant_csv_path = hash[:merchants]
    @invoice_csv_path = hash[:invoices]
    @transaction_csv_path = hash[:transactions]
    @invoice_items_csv_path = hash[:invoice_items]
    @customer_csv_path = hash[:customers]
  end

  def self.from_csv(hash)
    new(hash)
  end

  def find_merchant(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

  def find_items_by_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def find_invoices_by_merchant_id(merchant_id)
    @invoices.find_all_by_merchant_id(merchant_id)
  end

  def find_items_by_invoice_id(invoice_id)
    item_ids = @invoice_items.find_all_by_invoice_id(invoice_id).map(&:item_id)
    item_ids.map { |item_id| @items.find_by_id(item_id) }
  end

  def find_transactions_by_invoice_id(invoice_id)
    @transactions.find_all_by_invoice_id(invoice_id)
  end

  def find_customer_by_customer_id(customer_id)
    @customers.find_by_id(customer_id)
  end

  def find_invoice(invoice_id)
    @invoices.find_by_id(invoice_id)
  end

  def find_customers_by_merchant_id(merchant_id)
    customers = @invoices.find_all_by_merchant_id(merchant_id)
    customer_ids = customers.map(&:customer_id).uniq
    customer_ids.map { |customer_id| @customers.find_by_id(customer_id) }
  end

  def find_merchants_by_customer_id(customer_id)
    merchants = @invoices.find_all_by_customer_id(customer_id)
    merchant_ids = merchants.map(&:merchant_id)
    merchant_ids.map { |merch_id| @merchants.find_by_id(merch_id) }
  end

  def find_transaction_payment_status(invoice_id)
    payment_status = @transactions.find_all_by_invoice_id(invoice_id)
    transaction_results = payment_status.map(&:result)
    transaction_results.include?('success')
  end

  def total_invoice_cost(invoice_id)
    invoice_items = @invoice_items.find_all_by_invoice_id(invoice_id)
    total_prices = invoice_items.map do |invoice_item|
      invoice_item.quantity * invoice_item.unit_price
    end
    total_prices.reduce(:+)
  end

  def find_fully_paid_invoices(customer_id)
    invoices = @invoices.find_all_by_customer_id(customer_id)
    invoices.find_all(&:is_paid_in_full?)
  end

  def find_invoice_items(invoice_id)
    @invoice_items.find_all_by_invoice_id(invoice_id)
  end

  def find_invoice_by_customer(customer_id)
    @invoices.find_all_by_customer_id(customer_id)
  end
end
