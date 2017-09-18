require_relative 'merchant_repo'
require_relative 'item_repo'
require_relative 'invoice_repo'
require_relative 'invoice_item_repo'
require_relative 'transaction_repo'
require_relative 'customer_repo'
require 'pry'

class SalesEngine
  attr_reader :merchant_repo,
              :item_repo,
              :invoice_repo,
              :invoice_item_repo,
              :transaction_repo,
              :customer_repo

  def self.from_csv(data_hash)
    new(data_hash)
  end

  def initialize(data_hash)
    @merchant_repo = MerchantRepo.new(data_hash[:merchants],self)
    @item_repo = ItemRepo.new(data_hash[:items],self)
    @invoice_repo = InvoiceRepo.new(data_hash[:invoices],self)
    @invoice_item_repo = InvoiceItemRepo.new(data_hash[:invoice_items],self)
    @transaction_repo = TransactionRepo.new(data_hash[:transactions],self)
    @customer_repo = CustomerRepo.new(data_hash[:customers],self)
  end

  def merchants
    merchant_repo
  end

  def items
    item_repo
  end

  def invoices
    invoice_repo
  end

  def invoice_items
    invoice_item_repo
  end

  def transactions
    transaction_repo
  end

  def customers
    customer_repo
  end

  def merchant_items(id)
    item_repo.find_all_by_merchant_id(id)
  end

  def item_merchant(id)
    merchant_repo.find_by_id(id)
  end

  def merchant_invoices(id)
    invoice_repo.find_all_by_merchant_id(id)
  end

  def invoice_merchant(id)
    merchant_repo.find_by_id(id)
  end

  def invoice_item_ids_list(id)
    list = invoice_item_repo.find_all_by_invoice_id(id)
    list.map { |i| i.item_id }
  end

  def invoice_items_list(id)
    invoice_item_ids_list(id).map { |i| self.items.find_by_id(i) }
  end

  def invoice_transactions(id)
    transaction_repo.find_all_by_invoice_id(id)
  end

  def invoice_customer(id)
    customer_repo.find_by_id(id)
  end

  def transaction_invoice(id)
    invoice_repo.find_by_id(id)
  end

  def merchant_customers(id)
    merchant_list = invoices.find_all_by_merchant_id(id)
    merchant_list.map { |invoice| invoice.customer }.uniq
  end

  def customer_merchants(id)
    customer_list = invoices.find_all_by_customer_id(id)
    customer_list.map { |invoice| invoice.merchant }.uniq
  end

  def total(id)
  selected_invoices = invoice_items.find_all_by_invoice_id(id)
  totals_of_invoice_items = selected_invoices.map do |invoice_item|
    (invoice_item.quantity * invoice_item.unit_price)
    end
    totals_of_invoice_items.reduce(:+)
  end

end
