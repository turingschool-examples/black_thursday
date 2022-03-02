require "csv"
require "merchant"
require "item"
require "invoice"
require "customer"
require "transaction"
require "invoice_item"
require "sales_analyst"
require "pry"

class SalesEngine
  attr_reader :merchants_repo,
    :items_repo,
    :invoices_repo,
    :customers_repo,
    :transactions_repo,
    :invoice_items_repo,
    :analyst

  def initialize(data)
    @items_repo = ItemRepository.new(data[:items])
    @merchants_repo = MerchantRepository.new(data[:merchants])
    @invoices_repo = InvoiceRepository.new(data[:invoices])
    @customers_repo = CustomerRepository.new(data[:customers])
    @transactions_repo = TransactionRepository.new(data[:transactions])
    @invoice_items_repo = InvoiceItemRepository.new(data[:invoice_items])
    @analyst = SalesAnalyst.new(@items_repo, @merchants_repo, @invoices_repo, @customers_repo, @transactions_repo, @invoice_items_repo)
  end

  def self.from_csv(argument)
    SalesEngine.new(argument)
  end
end
