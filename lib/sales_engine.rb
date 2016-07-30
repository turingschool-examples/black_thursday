require 'CSV'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/customer_repository'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  extend Forwardable
  def_delegator :@items, :find_all_by_merchant_id, :find_items
  def_delegator :@items, :find_by_id, :find_item
  def_delegator :@merchants, :find_by_id, :find_merchant
  def_delegator :@invoices, :find_all_by_merchant_id, :find_invoices
  def_delegator :@invoices, :find_by_id, :find_invoice
  def_delegator :@invoices, :find_all_by_merchant_id, :find_customers
  def_delegator :@invoices, :find_all_by_customer_id, :find_merchants
  def_delegator :@transactions, :find_all_by_invoice_id, :find_transactions
  def_delegator :@customers, :find_by_id, :find_customer
  def_delegator :@invoice_items, :find_all_by_invoice_id, :find_invoice_items

  def initialize(list_of_paths)
    @list_of_paths = list_of_paths
    @items = ItemRepository.new(read_items_data, self)
    @merchants = MerchantRepository.new(read_merchants_data, self)
    @invoices = InvoiceRepository.new(read_invoices_data, self)
    @invoice_items = InvoiceItemRepository.new(read_invoice_items_data, self)
    @transactions = TransactionRepository.new(read_transactions_data, self)
    @customers = CustomerRepository.new(read_customers_data, self)
  end

  def self.from_csv(list_of_paths)
    SalesEngine.new(list_of_paths)
  end

  def read_items_data
    read_data(:items)
  end

  def read_merchants_data
    read_data(:merchants)
  end

  def read_invoices_data
    read_data(:invoices)
  end

  def read_invoice_items_data
    read_data(:invoice_items)
  end

  def read_transactions_data
    read_data(:transactions)
  end

  def read_customers_data
    read_data(:customers)
  end

  def read_data(what_to_read)
    return [] if @list_of_paths[what_to_read].nil?
    CSV.read(@list_of_paths[what_to_read],
             headers: true,
             header_converters: :symbol)
  end

  def find_items(id)
    items.find_all_by_merchant_id(id)
  end

  def find_merchant(merchant_id)
    merchants.find_by_id(merchant_id)
  end

end
