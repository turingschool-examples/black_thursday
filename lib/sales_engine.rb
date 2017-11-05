require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/customer_repository'

require 'pry'

class SalesEngine

  attr_reader :items, :merchants, :invoices,
              :invoice_items, :transactions, :customers

  def initialize(files)
    @items         = ItemRepository.new(files[:items], self)
    @merchants     = MerchantRepository.new(files[:merchants], self)
    @invoices      = InvoiceRepository.new(files[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(files[:invoice_items], self)
    @transactions  = TransactionRepository.new(files[:transactions], self)
    @customers = CustomerRepository.new(files[:customers], self)
  end

  def self.from_csv(files)
      SalesEngine.new(files)
  end

  def merchant(id)
    merchants.find_by_id(id)
  end

  def find_item_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end

  def find_invoices(id)
    invoices.find_all_by_merchant_id(id)
  end

  def find_items_by_invoice_id(id)
    invoice_items.find_all_by_invoice_id(id).map do |invoice_item|
      items.find_by_id(invoice_item.item_id)
    end.uniq
  end

  def find_items_by_invoice_id(id)
    invoice_items.find_all_by_invoice_id(id).map do |invoice_item|
      transactions.find_all_by_invoice_id(invoice_item.id)
    end
  end

  # def find_merchants(id)
  #   invoices.find_all_by_customer_id(id).map do |invoice|
  #     merchant(invoice.merchant_id)
  #   end
  # end

end
