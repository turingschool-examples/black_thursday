require_relative 'items_repo'
require_relative 'merchant_repo'
require_relative 'invoice_repo'
require_relative 'invoice_item_repo'
require_relative 'customer_repo'
require_relative 'transaction_repo'


class SalesEngine
  attr_reader :merchants, :items, :invoices, :invoice_items, :transactions, :customers

  def initialize(data)
    @merchants     = MerchantRepo.new(data[:merchants], self)
    @items         = ItemRepo.new(data[:items], self)
    @invoices      = InvoiceRepo.new(data[:invoices], self)
    @invoice_items = InvoiceItemRepo.new(data[:invoice_items], self)
    @transactions  = TransactionRepo.new(data[:transactions], self)
    @customers     = CustomersRepo.new(data[:customers], self)
  end

  def self.from_csv(data)
    se = SalesEngine.new(data)
  end

  def items_of_merchant(id)
    items.find_all_by_merchant_id(id)
  end

  def merchant_item(id)
    merchants.find_by_id(id)
  end
end
