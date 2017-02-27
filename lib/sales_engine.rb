require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'


class SalesEngine
  attr_accessor :merchants, :items, :invoices, :invoice_items, :transactions, :customers

  def self.from_csv(info)
    @merchant_repo = MerchantRepository.new(info[:merchants], self)
    @item_repo = ItemRepository.new(info[:items], self)
    @invoice_repo = InvoiceRepository.new(info[:invoices], self)
    @invoice_item_repo = InvoiceItemRepository.new(info[:invoice_items], self)
    @transaction_repo = TransactionRepository.new(info[:transactions], self)
    @customer_repo = CustomerRepository.new(info[:customers], self)
    self
  end

  def self.merchants
    @merchant_repo
  end

  def self.items
    @item_repo
  end

  def self.invoices
    @invoice_repo
  end

  def self.invoice_items
    @invoice_item_repo
  end

  def self.transactions
    @transaction_repo
  end

  def self.customers
    @customer_repo
  end

end
