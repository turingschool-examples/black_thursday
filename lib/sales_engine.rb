require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'


class SalesEngine
  attr_reader :items, :merchants, :invoices, :invoice_items,
              :transactions, :customers

  def self.from_csv(hash)
    SalesEngine.new(hash)
  end

  def initialize(hash)
    @items = ItemRepository.new(hash[:items], self)
    @merchants = MerchantRepository.new(hash[:merchants], self)
    @invoices = InvoiceRepository.new(hash[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(hash[:invoice_items], self)
    @transactions = TransactionRepository.new(hash[:transactions], self)
    @customers = CustomerRepository.new(hash[:customers], self)
  end

  def item_repo_finds_all_by_merchant_id(id)
    @items.find_all_by_merchant_id(id)
  end

  def merch_repo_find_all_by_id(id)
    @merchants.find_by_id(id)
  end

  def engine_finds_invoices_via_invoice_repo(id)
    @invoices.find_all_by_merchant_id(id)
  end

  def engine_finds_merchant_via_merchant_repo(id)
    @merchants.find_by_id(id)
  end

  def engine_finds_items_via_invoice_items_repo(id)
    @invoice_items.find_all_by_invoice_id(id)
  end
end
