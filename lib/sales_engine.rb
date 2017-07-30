require_relative 'merchant_repo'
require_relative 'item_repo'
require_relative 'invoice_repo'
require_relative 'invoice_item_repo'
require_relative 'transaction_repo'
require_relative 'customer_repo'
require_relative 'loader'
require 'pry'
require 'csv'

class SalesEngine
  attr_reader :items, :merchants, :invoices, :invoice_items, :transactions, :customers

  def initialize(se_hash)
    @items         = ItemRepository.new(se_hash[:items], self)
    @merchants     = MerchantRepository.new(se_hash[:merchants], self)
    @invoices      = InvoiceRepository.new(se_hash[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(se_hash[:invoice_items], self)
    @transactions  = TransactionRepository.new(se_hash[:transactions], self)
    @customers     = CustomerRepository.new(se_hash[:customers], self)
  end

  extend Loader

  def find_items_by_merchant_id(merchant_id)
    @items.find_all_items_to_a_merchant(merchant_id)
  end

  def find_merchant_by_id(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

  def find_invoices_by_merchant_id(merchant_id)
    @invoices.find_all_by_merchant_id(merchant_id)
  end

  def self.from_csv(se_hash)
    item_data         = self.load_items(se_hash[:items])
    merchant_data     = self.load_merchants(se_hash[:merchants])
    invoice_data      = self.load_invoices(se_hash[:invoices])
    invoice_item_data = self.load_invoice_items(se_hash[:invoice_items])
    transaction_data  = self.load_transactions(se_hash[:transactions])
    customer_data     = self.load_customers(se_hash[:customers])

    SalesEngine.new({:items => item_data,
                     :merchants => merchant_data,
                     :invoices => invoice_data,
                     :invoice_items => invoice_item_data,
                     :transactions => transaction_data,
                     :customers => customer_data})
  end


  def self.load_invoice_items(csvfile)
    CSV.open csvfile, headers: true, header_converters: :symbol
  end

  def self.load_transactions(csvfile)
    CSV.open csvfile, headers: true, header_converters: :symbol
  end

  def self.load_customers(csvfile)
    CSV.open csvfile, headers: true, header_converters: :symbol
  end

end
