require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require_relative 'invoice_item_repository'

# Data Access Layer
class SalesEngine
  attr_accessor :items,
                :merchants,
                :invoices,
                :transactions,
                :customers,
                :invoice_items

  def initialize(repositories)
    @items         = ItemRepository.new(
      repositories[:items],
      self
    )
    @merchants     = MerchantRepository.new(
      repositories[:merchants],
      self
    )
    @invoices      = InvoiceRepository.new(
      repositories[:invoices],
      self
    )
    @transactions  = TransactionRepository.new(
      repositories[:transactions],
      self
    )
    @customers     = CustomerRepository.new(
      repositories[:customers],
      self
    )
    @invoice_items = InvoiceItemRepository.new(
      repositories[:invoice_items],
      self
    )
  end

  def self.from_csv(repositories)
    new(repositories)
  end

  def find_merchant_items(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def find_item_merchant(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

  def find_merchant_invoices(id)
    @invoices.find_all_by_merchant_id(id)
  end

  def find_invoice_merchant(id)
    @merchants.find_by_id(id)
  end

  def find_transaction_invoice(invoice_id)
    @invoices.find_by_id(invoice_id)
  end

  def find_invoice_items(id)
    @invoice_items.find_all_by_invoice_id(id).map do |inv_item|
      @items.find_by_id(inv_item.item_id)
    end
  end

  def find_customer_merchants(id)
    @invoices.find_all_by_customer_id(id).map do |inv|
      @items.find_all_by_merchant_id(inv.merchant_id)
    end
  end

  def find_merchant_customers(id)
    @invoices.find_all_by_merchant_id(id).map do |inv|
      @customers.find_by_id(inv.customer_id)
    end
  end
end
