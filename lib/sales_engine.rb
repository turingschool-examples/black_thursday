require_relative 'items_repo'
require_relative 'merchant_repo'
require_relative 'invoice_repo'
require_relative 'invoice_item_repo'
require_relative 'customer_repo'
require_relative 'transaction_repo'


class SalesEngine
  attr_reader :merchants, :items, :invoices, :invoice_items,
              :transactions, :customers

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

  def find_merchant_by_invoice_id(invoice_id)
    @merchants.find_by_id(invoice_id)
  end

  def merchant_item(id)
    merchants.find_by_id(id)
  end

  def items_of_invoice
    invoice_items.return_item_id
  end

  def retrieve_item_id_from_items_repo(item_id)
    items.find_all_items_by_id(item_id)
  end

  def all_items_by_id(item_id)
    items.find_all_by_item_id(item_id)
  end

  def invoice_item_ids_list(id)
   list = invoice_items.find_all_by_invoice_id(id)
   list.map { |i| i.item_id }
  end

  def invoice_items_list(id)
    invoice_item_ids_list(id).map { |i| self.items.find_by_id(i) }
  end

  def transactions_invoice_id(invoice_id)
    transactions.find_all_by_invoice_id(invoice_id)
  end

  def customer_invoice_id(customer_id)
    customers.find_by_id(customer_id)
  end

  def invoice_items_unit_price(unit_price)
    invoice_items.unit_price_to_dollars(unit_price)
  end

  # def total_invoice_amount(invoice_id)
  #   successful_1_items = invoice_items.find_all_by_invoice_id(invoice_id)
  #   successful_1_items.map do |i_item|
  #   i_item.total
  # end.sum.round(2)
  # end

end
