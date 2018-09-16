require 'pry'


require_relative 'csv_parse'

require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

require_relative 'sales_analyst'



class SalesEngine

  attr_reader :merchants,
              :items,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(data)
    @data = data
    @merchants     = make_merchants
    @items         = make_items
    @invoices      = make_invoices
    @invoice_items = make_invoice_items
    @transactions  = make_transactions
    @customers     = make_customers
  end

  def self.from_csv(paths)
    hash = {}
    paths.each { |key, path|
      hash[key] = CSVParse.create_repo(path)
    }
    engine = self.new(hash)
  end


  # --- Repo Creation ---

  def make_merchants
    data = @data[:merchants]
    @merchants = MerchantRepository.new(data) if data
  end

  def make_items
    data = @data[:items]
    @items = ItemRepository.new(data) if data
  end

  def make_invoices
    data = @data[:invoices]
    @invoices = InvoiceRepository.new(data) if data
  end

  def make_invoice_items
    data = @data[:invoice_items]
    @invoice_items = InvoiceItemRepository.new(data) if data
  end

  def make_transactions
    data = @data[:transactions]
    @transactions = TransactionRepository.new(data) if data
  end

  def make_customers
    data = @data[:customers]
    @customers = CustomerRepository.new(data) if data
  end


  # --- Sales Analyst ---

  def analyst
    SalesAnalyst.new(self)
  end

end
