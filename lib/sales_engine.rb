require_relative 'items_repository'
require_relative 'merchant_repo'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require_relative 'sales_analyst'
require 'csv'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(items, merchants, invoices,
                 invoice_items, transactions, customers)
    @items = items
    @merchants = merchants
    @invoices = invoices
    @invoice_items = invoice_items
    @transactions = transactions
    @customers = customers
  end

  def self.from_csv(csv_hash)
    items = ItemsRepository.new
    merchants = MerchantRepo.new
    invoices = InvoiceRepository.new
    invoice_items = InvoiceItemsRepository.new
    transactions = TransactionRepository.new
    customers = CustomerRepository.new

    if csv_hash[:items]
      items_filepath = csv_hash[:items]
      csv_items = CSV.open items_filepath,
                           headers: true,
                           header_converters: :symbol,
                           converters: :all
      items.load_items(csv_items)
    end
    if csv_hash[:merchants]
      merchants_filepath = csv_hash[:merchants]
      csv_merchants = CSV.open merchants_filepath,
                               headers: true,
                               header_converters: :symbol
      merchants.load_merchants(csv_merchants)
    end
    if csv_hash[:invoices]
      invoices_filepath = csv_hash[:invoices]
      csv_invoices = CSV.open invoices_filepath,
                              headers: true,
                              header_converters: :symbol
      invoices.load_invoices(csv_invoices)
    end
    if csv_hash[:invoice_items]
      invoice_items_filepath = csv_hash[:invoice_items]
      csv_items = CSV.open invoice_items_filepath,
                           headers: true,
                           header_converters: :symbol,
                           converters: :all
      invoice_items.load_invoice_items(csv_items)
    end
    if csv_hash[:transactions]
      transactions_filepath = csv_hash[:transactions]
      csv_merchants = CSV.open transactions_filepath,
                               headers: true,
                               header_converters: :symbol
      transactions.load_transactions(csv_merchants)
    end
    if csv_hash[:customers]
      customers_filepath = csv_hash[:customers]
      csv_invoices = CSV.open customers_filepath,
                              headers: true,
                              header_converters: :symbol
      customers.load_customers(csv_invoices)
    end
    new(items, merchants, invoices,
        invoice_items, transactions, customers)
  end

  def analyst
    SalesAnalyst.new(@items, @merchants, @invoices,
                     @invoice_items, @transactions, @customers)
  end
end
