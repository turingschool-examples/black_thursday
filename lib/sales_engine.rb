require_relative "item_repo"
require_relative "merchant_repo"
require_relative "invoice_repo"
require_relative "invoice_items_repo"
require_relative "transaction_repo"
require_relative "customer_repo"

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices

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

  def find_items(id)
    items.find_by_all_merchant_id(id)
  end

  def find_invoices(id)
    invoices.find_all_by_merchant_id(id)
  end

  # def find_invoice_items(id)
end
