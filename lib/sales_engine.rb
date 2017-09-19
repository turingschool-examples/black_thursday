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
    @invoice_items = InvoiceItemRepository.new(i_items, self)
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

end
