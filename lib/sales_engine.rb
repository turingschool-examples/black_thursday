require_relative './merchant_repository'
require_relative './item_repository'
require_relative './invoice_repository'
require_relative './customer_repository'
require_relative './invoice_item_repository'
require_relative './transaction_repository'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :customers,
              :invoice_items,
              :transactions

  def initialize(file_path)
    @merchants     = MerchantRepository.new(file_path[:merchants], self)
    @items         = ItemRepository.new(file_path[:items], self)
    @invoices      = InvoiceRepository.new(file_path[:invoices], self)
    @customers     = CustomerRepository.new(file_path[:customers], self)
    @invoice_items = InvoiceItemRepository.new(file_path[:invoice_items], self)
    @transactions  = TransactionRepository.new(file_path[:transactions], self)
  end

  def self.from_csv(file_path)
   SalesEngine.new(file_path)
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def find_merchant_that_owns_item(item_id)
    @merchants.find_by_id(item_id)
  end

  def find_invoices_by_merchant_id(merchant_id)
    @invoices.find_all_by_merchant_id(merchant_id)
  end

  def find_merchant_from_invoice(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

  def find_items_by_invoice(id)
    arr = @invoice_items.find_all_by_invoice_id(id)
    arr.map {|item| @items.find_by_id(item.item_id)}
  end

  def find_transactions_by_invoice(id)
    @transactions.find_all_by_invoice_id(id)
  end

  def find_customer_by_invoice(id)
    @customers.find_by_id(id)
  end

  def find_invoice_by_transaction_id(id)
    @invoices.find_by_id(id)
  end

  def find_all_customers_per_merchant(id)
    invoices = @invoices.find_all_by_merchant_id(id)
    invoices.map {|invoice| @customers.find_by_id(invoice.customer_id)}.uniq
  end

  def find_invoice_items(id)
    @invoice_items.find_all_by_invoice_id(id)
  end

  def find_merchants_by_customer(id)
    invoices = @invoices.find_all_by_customer_id(id)
    invoices.map {|invoice| @merchants.find_by_id(invoice.merchant_id)}
  end
end
