require "csv"
require_relative "merchant_repo"
require_relative "item_repo"
require_relative "invoice_repo"
require_relative "invoice_item_repo"
require_relative "customer_repo"
require_relative "transaction_repo"

class SalesEngine
  attr_reader :merchants,
              :items,
              :invoices,
              :invoice_items,
              :customers,
              :transactions

  def self.from_csv(directory)
    SalesEngine.new(directory)
  end

  def initialize(directory)
    @merchants     = MerchantRepo.new(self, directory[:merchants])
    @items         = ItemRepo.new(self, directory[:items])
    @invoices      = InvoiceRepo.new(self, directory[:invoices])
    @invoice_items = InvoiceItemRepo.new(self, directory[:invoice_items])
    @customers     = CustomerRepo.new(self, directory[:customers])
    @transactions  = TransactionRepo.new(self, directory[:transactions])
  end

  def find_items_by_merchant_id(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def find_merchant(id)
    merchants.find_by_id(id)
  end

  def find_invoices_by_merchant_id(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end

  def find_invoice_items_by_invoice_id(id)
    invoice_items.find_all_by_invoice_id(id)
  end

  def find_item_by_item_id(id)
    items.find_by_id(id)
  end

  def find_transactions_by_invoice_id(id)
    transactions.find_all_by_invoice_id(id)
  end

  def find_customer_by_id(id)
    customers.find_by_id(id)
  end
end
