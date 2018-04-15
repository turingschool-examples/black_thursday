require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'item_repository'
require_relative 'invoice_item_repository'
require_relative 'sales_analyst'
require_relative 'transaction_repository'
require_relative 'customer_repository'

class SalesEngine
  attr_reader :path,
              :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(path)
    @items         ||= ItemRepository.new(path[:items], self)
    @merchants     ||= MerchantRepository.new(path[:merchants], self)
    @invoices      ||= InvoiceRepository.new(path[:invoices], self)
    @invoice_items ||= InvoiceItemRepository.new(path[:invoice_items], self)
    @transactions  ||= TransactionRepository.new(path[:transactions], self)
    @customers     ||= CustomerRepository.new(path[:customers], self)
  end

  def self.from_csv(path)
    SalesEngine.new(path)
  end

  def analyst
    SalesAnalyst.new(self)
  end

  def invoices_for_merchant(id)
    invoices.find_all_by_merchant_id(id)
  end

  def items_for_a_merchant(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def find_customers_for_a_merchant(customer_id)
    customers.find_by_id(customer_id)
  end



end
