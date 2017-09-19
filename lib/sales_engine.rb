require_relative 'merchant_repo'
require_relative 'item_repo'
require_relative 'invoice_repo'
require_relative 'invoice_item_repo'
require_relative 'transaction_repo'
require_relative 'customer_repo'
require 'csv'

class SalesEngine
  def self.from_csv(files)
    items = files[:items]
    merchs = files[:merchants]
    invoices = files[:invoices]
    i_items = files[:invoice_items]
    trans = files[:transactions]
    customers = files[:customers]
    SalesEngine.new(items, merchs, invoices, i_items, trans, customers)
  end

  attr_reader :merchants, :items, :invoices, :i_items, :trans, :customers

  def initialize(items, merchants, invoices, i_items, trans, customers)
    @items = ItemRepository.new(items, self)
    @merchants = MerchantRepository.new(merchants, self)
    @invoices = InvoiceRepository.new(invoices, self)
    @i_items = InvoiceItemRepository.new(i_items, self)
    @trans = TransactionRepository.new(trans, self)
    @customers = CustomerRepository.new(customers, self)
  end

  def find_merchant_items(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def find_item_merchant(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def find_merchant_invoice(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end

  def find_invoice_for_merchant(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def find_item_ids(invoice_id)
    i_items_list = i_items.find_all_by_invoice_id(invoice_id)
    i_items_list.map do |i_item|
      i_item.item_id
    end
  end

  def find_items_for_invoices(invoice_id)
    item_ids = find_item_ids(invoice_id)
    item_ids.map do |item_id|
      items.find_by_id(item_id)
    end
  end

  def find_transactions_for_invoice(invoice_id)
    trans.find_all_by_invoice_id(invoice_id)
  end

  def find_customer_from_invoice(customer_id)
    customers.find_by_id(customer_id)
  end
end
