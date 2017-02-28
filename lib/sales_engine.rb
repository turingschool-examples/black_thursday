require_relative './item_repository'
require_relative './merchant_repository'
require_relative './invoice_repository'
require_relative './invoice_item_repository'
require_relative './transaction_repository'
require_relative './customer_repository'

class SalesEngine

  attr_accessor :items, :merchants, :invoices, :invoice_items, :transactions, :customers

  def initialize(hash)
    unless hash[:items].nil?
      @items = ItemRepository.new(hash[:items], self)
    end
    unless hash[:merchants].nil?
      @merchants = MerchantRepository.new(hash[:merchants], self)
    end
    unless hash[:invoices].nil?
      @invoices = InvoiceRepository.new(hash[:invoices], self)
    end
    unless hash[:invoice_items].nil?
      @invoice_items = InvoiceItemRepository.new(hash[:invoice_items], self)
    end
    unless hash[:transactions].nil?
      @transactions = TransactionRepository.new(hash[:transactions], self)
    end
    unless hash[:customers].nil?
      @customers = CustomerRepository.new(hash[:customers], self)
    end
  end

  def self.from_csv(hash)
    SalesEngine.new(hash)
  end
end
