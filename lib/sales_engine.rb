require 'csv'
require_relative 'itemrepository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'

class SalesEngine
  attr_reader :analyst,
              :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions

  def self.from_csv(paths)
    item_path = paths[:items]
    merchant_path = paths[:merchants]
    invoice_path = paths[:invoices]
    invoice_item_path = paths[:invoice_items]
    transaction_path = paths[:transactions]
  end

  def initialize
    @analyst = SalesAnalyst.new
    @items = ItemRepository.new('./data/items.csv')
    @merchants = MerchantRepository.new('./data/merchants.csv')
    @invoices = InvoiceRepository.new('./data/invoices.csv')
    @invoice_items = InvoiceItemRepository.new('./data/invoice_items.csv')
    @transactions = TransactionRepository.new('./data/transactions.csv')
  end

end
