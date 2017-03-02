require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require 'pry'


class SalesEngine
  attr_accessor :items,
                :merchants,
                :invoices,
                :invoice_items,
                :customers,
                :transactions

  def initialize(file_hash)
    @customers = CustomerRepository.new(self, file_hash[:customers])
    @transactions = TransactionRepository.new(self, file_hash[:transactions])
    @invoice_items = InvoiceItemRepository.new(self, file_hash[:invoice_items])
    @invoices = InvoiceRepository.new(self, file_hash[:invoices])
    @items = ItemRepository.new(self, file_hash[:items])
    @merchants = MerchantRepository.new(self, file_hash[:merchants])
  end

  def self.from_csv(file_hash)
    SalesEngine.new(file_hash)
  end

  def number_of_merchants
    merchants.count
  end

  def number_of_items
    items.count
  end

  def number_of_items_per_merchant
    items.data.group_by(&:merchant_id).values.map(&:count)
  end

  def prices_of_each_item
    items.all.map { |item| item.unit_price }
  end

  def number_of_invoices
    invoices.data.count
  end

  def number_of_invoices_per_merchant
    invoices.data.group_by(&:merchant_id).values.map(&:count)
  end


end
