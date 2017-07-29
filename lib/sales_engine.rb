require 'CSV'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require 'pry'

class SalesEngine

  def self.from_csv(hash)
    SalesEngine.new(hash)
  end

  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(hash)
    @items = ItemRepository.new(hash[:items], self)
    @merchants = MerchantRepository.new(hash[:merchants], self)
    @invoices = InvoiceRepository.new(hash[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(hash[:invoice_items], self)
    @transactions = TransactionRepository.new(hash[:transactions], self)
    @customers = CustomerRepository.new(hash[:customers], self)
  end

  def fetch_merchant_id(merchant_id)
    pass_merchant_id(merchant_id)
  end

  def pass_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def fetch_items_merchant_id(merchant_id)
    pass_items_merchant_id(merchant_id)
  end

  def pass_items_merchant_id(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

  def fetch_invoices_for_merchant(merchant_id)
    @invoices.find_all_by_merchant_id(merchant_id)
  end

  def fetch_merchant_from_invoice_id(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

  def fetch_items_from_invoice_id(invoice_id)
    invoice_items = @invoice_items.find_all_by_invoice_id(invoice_id)
    item_id_array = invoice_items.map do |invoice_item|
      invoice_item.item_id
    end
    fetch_items_from_collection_of_item_ids(item_id_array)
  end

  def fetch_items_from_collection_of_item_ids(item_id_array)
    item_id_array.map do |item_id|
      items.find_by_id(item_id)
    end
  end

  def fetch_transactions_from_invoice_id(invoice_id)
    @transactions.find_all_by_invoice_id(invoice_id)
  end

  def fetch_customer_from_invoice_id(customer_id)
    @customers.find_by_id(customer_id)
  end

  def fetch_invoice_from_transaction_id(invoice_id)
    @invoices.find_by_id(invoice_id)
  end

  def fetch_customers_from_merchant_id(merchant_id)
    invoices = @invoices.find_all_by_merchant_id(merchant_id)
    customer_id_array = invoices.map do |invoice|
      invoice.customer_id
    end
    fetch_customers_with_customer_id(customer_id_array)
  end

  def fetch_customers_with_customer_id(customer_id_array)
    customer_id_array.map do |customer_id|
       customers.find_by_id(customer_id)
      end
  end

  # def fetch_items_from_invoice_id(invoice_id)
  #   invoice_items = @invoice_items.find_all_by_invoice_id(invoice_id)
  #   item_id_array = invoice_items.map do |invoice_item|
  #     invoice_item.item_id
  #   end
  #   fetch_items_from_collection_of_item_ids(item_id_array)
  # end
  #
  # def fetch_items_from_collection_of_item_ids(item_id_array)
  #   item_id_array.map do |item_id|
  #     items.find_by_id(item_id)
  #   end
  # en

  def call_merchants
    @merchants.merchants
  end

  def call_items
    @items.items
  end

end
