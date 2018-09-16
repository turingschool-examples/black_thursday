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
    @customers = make_customers
    # @merchants     = make_merchants(data[:merchants])         if data[:merchants]
    # @items         = make_items(data[:items])                 if data[:items]
    # @invoices      = make_invoices(data[:invoices])           if data[:invoices]
    # @invoice_items = make_invoice_items(data[:invoice_items]) if data[:invoice_items]
    # @transactions  = make_transactions(data[:transactions])   if data[:transactions]
    # @customers     = make_customers(data[:customers])         if data[:customers]
    # @customers     = make_customers(data[:customers])         if data[:customers]
    @merchants     = MerchantRepository.new(data[:merchants])        if data[:merchants]
    @items         = ItemRepository.new(data[:items])                if data[:items]
    @invoices      = InvoiceRepository.new(data[:invoices])          if data[:invoices]
    @invoice_items = InvoiceItemRepository.new(data[:invoice_items]) if data[:invoice_items]
    @transactions  = TransactionRepository.new(data[:transactions])  if data[:transactions]
    @customers     = CustomerRepository.new(data[:customers])        if data[:customers]
    # @customers     = CustomerRepository.new(data[:customers])        if data[:customers]
  end

  def self.from_csv(paths)
    hash = {}
    paths.each { |key, path|
      hash[key] = CSVParse.create_repo(path)
    }
    engine = self.new(hash)
  end


  # # --- Repo Creation ---
  #
  # def make_merchants(data)
  #   @merchants = MerchantRepository.new(data)
  # end
  #
  # def make_items(data)
  #   @items = ItemRepository.new(data)
  # end
  #
  # def make_invoices(data)
  #   @invoices = InvoiceRepository.new(data)
  # end
  #
  # def make_invoice_items(data)
  #   @invoice_items = InvoiceItemRepository.new(data)
  # end
  #
  # def make_transactions(data)
  #   @transactions = TransactionRepository.new(data)
  # end
  #
  # def make_customers(data)
  #   @customers = CustomerRepository.new(data)
  # end

  def make_customers
    data = @data[:customers]
    @customers = CustomerRepository.new(data) if data
  end


  # --- Sales Analyst ---

  def analyst
    SalesAnalyst.new(self)
  end

end
