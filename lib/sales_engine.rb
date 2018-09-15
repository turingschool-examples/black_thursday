require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'item'
require_relative 'merchant'
require_relative 'sales_analyst'
require_relative 'invoice'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'invoice_item'
require_relative 'transaction'
require_relative 'transaction_repository'
require_relative 'customer'
require_relative 'customer_repository'


class SalesEngine
  attr_reader :data
  def initialize(data)
    @data = data
  end

  def self.from_csv(data)
    new(data)
  end

  def items
  @items ||=  ItemRepository.new(data[:items])
  end

  def merchants
  @merchants ||=  MerchantRepository.new(data[:merchants])
  end

  def analyst
    SalesAnalyst.new(self)
  end

  def invoices
  @invoices ||= InvoiceRepository.new(data[:invoices])
  end

  def invoice_items
    @invoice_items ||= InvoiceItemRepository.new(data[:invoice_items])
  end

  def transactions
    @transactions ||= TransactoinRepository.new(data[:transactions])
  end

  def customers
    @customers ||= CustomerRepository.new(data[:customers])
  end

end
