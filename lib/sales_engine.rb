require 'csv'
require 'time'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'
require_relative '../lib/repository_loaders'
require_relative '../lib/invoice_item'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/transaction'
require_relative '../lib/transaction_repository'
require_relative '../lib/customer'
require_relative '../lib/customer_repository'


class SalesEngine
  attr_accessor :items,
                :merchants,
                :invoices,
                :invoice_items,
                :transactions,
                :customers

  def initialize
    @items = nil
    @merchants = nil
    @invoices = nil
    @invoice_items = nil
    @transactions = nil
    @customers = nil
  end

  def self.from_csv(loadpath_hash)

    items_rows = load_file(loadpath_hash[:items])
    merchants_rows = load_file(loadpath_hash[:merchants])
    invoices_rows = load_file(loadpath_hash[:invoices])
    invoice_items_rows = load_file(loadpath_hash[:invoice_items])
    transactions_rows = load_file(loadpath_hash[:transactions])
    customers_rows = load_file(loadpath_hash[:customers])

    sales_engine = SalesEngine.new
    repository_loader = RepositoryLoaders.new(sales_engine)

    sales_engine.items = repository_loader.load_items_into_repository(items_rows)
    sales_engine.merchants = repository_loader.load_merchants_into_repository(merchants_rows)
    sales_engine.invoices = repository_loader.load_invoices_into_repository(invoices_rows)
    sales_engine.invoice_items = repository_loader.load_invoice_items_into_repository(invoice_items_rows)
    sales_engine.transactions = repository_loader.load_transactions_into_repository(transactions_rows)
    sales_engine.customers = repository_loader.load_customers_into_repository(customers_rows)


    sales_engine
  end

  def self.load_file(loadpath)
    CSV.open loadpath, headers: true, header_converters: :symbol
  end





end
