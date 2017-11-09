require_relative "item_repo"
require_relative "merchant_repo"
require_relative "invoice_repo"
require_relative "invoice_item_repo"
require_relative "transaction_repo"
require_relative "customer_repo"

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def self.from_csv(directory)
    SalesEngine.new(directory)
  end

  def initialize(directory)
    @items         = ItemRepository.new(self, directory[:items])
    @merchants     = MerchantRepository.new(self, directory[:merchants])
    @invoices      = InvoiceRepository.new(self, directory[:invoices])
    @invoice_items = InvoiceItemRepository.new(self, directory[:invoice_items])
    @transactions  = TransactionRepository.new(self, directory[:transactions])
    @customers     = CustomerRepository.new(self, directory[:customers])
  end

  def find_merchant(id)
    merchants.find_by_id(id)
  end

  def find_items_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end

  def find_items_by_invoice_id(id)
    invoice_items.find_all_by_invoice_id(id)
  end

  def find_item_by_item_id(id)
    items.find_by_id(id)
  end

  def find_invoices_by_merchant_id(id)
    invoices.find_all_by_merchant_id(id)
  end

  def find_invoices_by_customer_id(id)
    invoices.find_all_by_customer_id(id)
  end

  def find_transactions_by_invoice_id(id)
    transactions.find_all_by_invoice_id(id)
  end

  def find_customer_by_customer_id(id)
    customers.find_by_id(id)
  end

  def find_invoice_by_invoice_id(id)
    invoices.find_by_id(id)
  end

  def find_merchant_by_merchant_id(id)
    merchants.find_by_id(id)
  end

  def find_invoice_items_by_invoice_id(id)
    invoice_items.find_all_by_invoice_id(id)
  end

  def find_item_by_item_id(id)
    items.find_by_id(id)
  end
end
