require_relative 'helper'

class SalesEngine

  include CsvParser

  attr_reader :merchants,
              :items,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(files = {})
    @merchants = create_merchant_repository(files)
    @items = create_item_repository(files)
    @invoices = create_invoice_repository(files)
    @invoice_items = create_invoice_item_repository(files)
    @transactions = create_transaction_repository(files)
    @customers = create_customer_repository(files)
  end

  def self.from_csv(files)
    new(files)
  end

  def create_merchant_repository(files)
    if files.include?(:merchants)
      MerchantRepository.new(open_file(files[:merchants]), self)
    end
  end

  def create_item_repository(files)
    if files.include?(:items)
      ItemRepository.new(open_file(files[:items]), self)
    end
  end

  def create_invoice_repository(files)
    if files.include?(:invoices)
      InvoiceRepository.new(open_file(files[:invoices]), self)
    end
  end

  def create_invoice_item_repository(files)
    if files.include?(:invoice_items)
      InvoiceItemRepository.new(open_file(files[:invoice_items]), self)
    end
  end

  def create_transaction_repository(files)
    if files.include?(:transactions)
      TransactionRepository.new(open_file(files[:transactions]), self)
    end
  end

  def create_customer_repository(files)
    if files.include?(:customers)
      CustomerRepository.new(open_file(files[:customers]), self)
    end
  end

#-----navigation_methods-----#
  def find_invoice_items_by_invoice_id(invoice_id)
    invoice_items.find_all_by_invoice_id(invoice_id)
  end

  def find_items_by_invoice_id(invoice_id)
    returned_invoice_items = find_invoice_items_by_invoice_id(invoice_id)
    item_ids = returned_invoice_items.map {|returned_invoice_item| returned_invoice_item.item_id}
    item_ids.map {|item_id| items.find_by_id(item_id)}
  end

  def find_transactions_by_invoice_id(invoice_id)
    transactions.find_all_by_invoice_id(invoice_id)
  end

  def find_customer_by_customer_id(customer_id)
    customers.find_by_id(customer_id)
  end

  def find_invoice_by_invoice_id(invoice_id)
    invoices.find_by_id(invoice_id)
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end

  def find_customer_for_each_invoice(merchant_id)
    merchant_invoices = find_all_by_merchant_id(merchant_id)
    customer_ids = merchant_invoices.map { |invoice| invoice.customer_id }
    (customer_ids.map { |id| find_customer_by_customer_id(id) }).uniq
  end

  def find_invoices_by_customer_id(customer_id)
    invoices.find_all_by_customer_id(customer_id)
  end

  def find_merchants_by_customer_id(customer_id)
    customer_invoices = find_invoices_by_customer_id(customer_id)
    merchant_ids = customer_invoices.map { |invoice| invoice.merchant_id }
    merchant_ids.map { |merchant_id| merchants.find_by_id(merchant_id) }
  end
#-----/navigation_methods----#

end