require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

class SalesEngine

  attr_reader   :items,
                :merchants,
                :invoices,
                :invoice_items,
                :transactions,
                :customers

  def initialize(filepath = nil)
    @items          = ItemRepository.new(filepath[:items], self)
    @merchants      = MerchantRepository.new(filepath[:merchants], self)
    @invoices       = InvoiceRepository.new(filepath[:invoices], self)
    @invoice_items  = InvoiceItemRepository.new(filepath[:invoice_items], self)
    @transactions   = TransactionRepository.new(filepath[:transactions], self)
    @customers      = CustomerRepository.new(filepath[:customers], self)
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end

  def find_items_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end

  def find_merchant_by_merchant_id(id)
    merchants.find_by_id(id)
  end

  def find_invoices_by_merchant_id(id)
    invoices.find_all_by_merchant_id(id)
  end

end
