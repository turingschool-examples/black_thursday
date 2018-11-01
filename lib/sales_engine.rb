require_relative './merchant_repository'
require_relative './item_repository'
require_relative './merchant'
require_relative './item'
require_relative './invoice_repository'
require_relative './invoice'
require_relative './transaction_repository'
require_relative './transaction'
require_relative './sales_analyst'
require_relative './csv_reader'
require_relative './invoice_item_repository'
require_relative './invoice_item'
require_relative './customer'
require_relative './customer_repository'

class SalesEngine
  attr_reader :merchants, :items, :invoices, :transactions, :invoice_items,
              :customers

  def initialize(repositories)
    @merchants = repositories[:merchants] if repositories.has_key?(:merchants)
    @items = repositories[:items] if repositories.has_key?(:items)
    @invoices = repositories[:invoices] if repositories.has_key?(:invoices)
    @invoice_items = repositories[:invoice_items] if repositories.has_key?(:invoice_items)
    @transactions = repositories[:transactions] if repositories.has_key?(:transactions)
    @customers = repositories[:customers] if repositories.has_key?(:customers)
  end

  def self.from_csv(file_paths)
    if file_paths.has_key?(:merchants)
      mr = MerchantRepository.new
      merchants = CSVReader.parse_merchants(mr, file_paths[:merchants])
    end
    if file_paths.has_key?(:items)
      ir = ItemRepository.new
      items = CSVReader.parse_items(ir, file_paths[:items])
    end
    if file_paths.has_key?(:invoices)
      inr = InvoiceRepository.new
      invoices = CSVReader.parse_invoices(inr, file_paths[:invoices])
    end
    if file_paths.has_key?(:invoice_items)
      iir = InvoiceItemRepository.new
      invoice_items = CSVReader.parse_invoice_items(iir, file_paths[:invoice_items])
    end
    if file_paths.has_key?(:transactions)
      tr = TransactionRepository.new
      transactions = CSVReader.parse_transactions(tr, file_paths[:transactions])
    end
    if file_paths.has_key?(:customers)
      cr = CustomerRepository.new
      customers = CSVReader.parse_customers(cr, file_paths[:customers])
    end

    SalesEngine.new({merchants: merchants, items: items, invoices: invoices,
      transactions: transactions, invoice_items: invoice_items,
      customers: customers})
  end

  def analyst
    SalesAnalyst.new({merchants: @merchants, items: @items, invoices: @invoices,
      invoice_items: @invoice_items, transactions: @transactions,
      customers: @customers})
  end
end
