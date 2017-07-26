require './lib/merchant_repo'
require './lib/item_repo'
require './lib/invoice_repo'
require './lib/invoice_item_repo'
require './lib/transaction_repo'
require './lib/customer_repo'
require 'pry'
require 'csv'

class SalesEngine
  attr_reader :items, :merchants, :invoices, :invoice_items, :transactions, :customers

  def initialize(se_hash)
    @items         = ItemRepository.new(se_hash[:items], self)
    @merchants     = MerchantRepository.new(se_hash[:merchants], self)
    @invoices      = InvoiceRepository.new(se_hash[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(:invoice_items, self)
    @transactions  = TransactionRepository.new(:transactions, self)
    @customers     = CustomerRepository.new(:customers, self)
  end

  def self.from_csv(se_hash)
    merchant_data     = load_merchants(se_hash[:merchants])
    item_data         = load_items(se_hash[:items])
    invoice_data      = load_data(se_hash[:invoices])
    invoice_item_data = load_data(se_hash[:invoice_items])
    transaction_data  = load_data(se_hash[:transactions])
    customer_data     = load_data(se_hash[:customers])

    SalesEngine.new(item_data, merchant_data, invoice_data, invoice_item_data, transaction_data, customer_data)
  end

  def self.load_merchants(csvfile)
    contents = CSV.open csvfile, headers: true, header_converters: :symbol
    all_merchants = {}
    contents.each do |row|
      all_merchants[row[0]] = Merchant.new({:id => row[0], :name => row[1]}, self)
    end
    all_merchants
  end

  def self.load_items(csvfile)
    # change the variable name
    contents = CSV.open csvfile, headers: true, header_converters: :symbol
    all_items = {}
    contents.each do |row|
      all_items[row[0]] = Item.new({:id => row[0], :name => row[1]}, self)
    end
    all_items
  end



end
