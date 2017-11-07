require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require_relative 'invoice_item_repository'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :transactions,
              :customers,
              :invoice_items

  def self.from_csv(csv_files)
    SalesEngine.new(csv_files)
  end

  def initialize(repos)
    @items        = ItemRepository.new(repos[:items], self)
    @merchants    = MerchantRepository.new(repos[:merchants], self)
    @invoices     = InvoiceRepository.new(repos[:invoices], self)
    @transactions = TransactionRepository.new(repos[:transactions], self)
    @customers    = CustomerRepository.new(repos[:customers], self)
    @invoice_items = InvoiceItemRepository.new(repos[:invoice_items], self)
  end

  def find_customer_by_invoice_id(id)
    customers.find_by_id(id)
  end

  def find_invoice_by_transaction_id(id)
    invoices.find_by_id(id)
  end

  def find_invoice_item_by_invoice_id(id)
    invoice_items.find_all_by_invoice_id(id)
  end

  def find_invoices_by_merchant(id)
    invoices.find_all_by_merchant_id(id)
  end

  def find_merchant_by_invoice(merchant)
    merchants.find_by_id(merchant)
  end

  def find_invoices_by_id(id)
    invoices.find_by_id(id)
  end

  def find_transaction_by_invoice_id(id)
    transactions.find_all_by_invoice_id(id)
  end

  def find_item_by_invoice_id(id)
    invoice_items.find_all_by_invoice_id(id).map do |invoice|
      items.find_by_id(invoice.item_id)
    end
  end

  def find_customer_by_merchant_id(id)
      invoices.find_all_by_merchant_id(id).map do |invoice|
        customers.find_by_id(invoice.customer_id)
    end.uniq
  end
end
