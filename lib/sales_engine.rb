require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'sales_analyst'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
# Ties together DAL
class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions

  def initialize(attributes)
    @items = ItemRepository.new(self)
    @items.from_csv(attributes[:items]) if attributes[:items]
    @merchants = MerchantRepository.new(self)
    @merchants.from_csv(attributes[:merchants]) if attributes[:merchants]
    @invoices = InvoiceRepository.new(self)
    @invoices.from_csv(attributes[:invoices]) if attributes[:invoices]
    @invoice_items = InvoiceItemRepository.new(self)
    @invoice_items.from_csv(attributes[:invoice_items]) if attributes[:invoice_items]
    @transactions = TransactionRepository.new(self)
    @transactions.from_csv(attributes[:transactions]) if attributes[:transactions]
  end

  def self.from_csv(attributes)
    SalesEngine.new(attributes)
  end

  def analyst
    @analyst ||= SalesAnalyst.new(self)
  end
end
