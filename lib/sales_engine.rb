require_relative 'item_repo'
require_relative 'merchant_repo'
require_relative 'invoice_repo'
require_relative 'customer_repo'
require_relative 'transaction_repo'
require_relative 'invoice_item_repo'

class SalesEngine
  attr_reader :invoices, :merchants, :items, :customers,
              :transactions, :invoice_items

  def initialize(data)
    @invoices      = InvoiceRepo.new(data[:invoices], self)
    @merchants     = MerchantRepo.new(data[:merchants], self)
    @items         = ItemRepo.new(data[:items], self)
    @customers     = CustomerRepo.new(data[:customers], self)
    @transactions  = TransactionRepo.new(data[:transactions], self)
    @invoice_items = InvoiceItemRepo.new(data[:invoice_items], self)
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end

  def total(id)
    thing = invoice_items.find_all_by_invoice_id(id)
    thing.map do |invoice_item|
      invoice_item.quantity * invoice_item.unit_price
    end.reduce(:+)
  end

  def customers_of_merchant(id)
    merchant_list = invoices.find_all_by_merchant_id(id)
    merchant_list.map {|invoice| invoice.customer}.uniq
  end

  def transaction_invoice(id)
    invoices.find_by_id(id)
  end

  def customer_invocies(id)
    customers.find_by_id(id)
  end

  def invoice_transactions(id)
    transactions.find_all_by_invoice_id(id)
  end

  def items_from_invoice(id)
    invoice_item_list = invoice_items.find_all_by_invoice_id(id)
    item_list = invoice_item_list.group_by {|invoice_item| invoice_item.item_id}
    item_list.keys.map {|id| items.find_by_id(id)}

  end

  def items_of_merchant(id)
    items.find_all_by_merchant_id(id)
  end

  def invoices_of_merchant(id)
    invoices.find_all_by_merchant_id(id)
  end

  def merchant_item(id)
    merchants.find_by_id(id)
  end

  def merchant_invoice(id)
    merchants.find_by_id(id)
  end

  def all_items
    items.all
  end

  def all_merchants
    merchants.all
  end

  def all_invoices
    invoices.all
  end

  def all_invoice_items
    invoice_items.all
  end

  def all_customers
    customers.all
  end
end
