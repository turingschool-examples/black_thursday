require_relative "merchant_repository"
require_relative 'item'
require_relative 'merchant'
require 'csv'
class SalesEngine
  attr_reader :items_array, :merchants_array
  def initialize(files)
    @items_array = []
    @merchants_array = []
    @invoice_array = []
    @invoice_items_array = []
    @customer_array = []
    @transaciton_array = []
    @files = files
  end
  def self.from_csv(files)
    engine = SalesEngine.new(files)
    engine.file_helper(files, :items, Item)
    engine.file_helper(files, :merchants, Merchant)
    # engine.file_helper(files, :invoices, Invoice)
    # engine.file_helper(files, :invoice_items, InvoiceItem)
    # engine.file_helper(files, :customers, Customer)
    # engine.file_helper(files, :transactions, Transaction)
    engine
  end
  def merchants
    MerchantRepository.new(@stash)
  end
  def items
    ItemRepository.new(@stash)
  end

  def file_helper(files, key, klass)
    reader = CSV.open(files[key], headers: true, header_converters: :symbol)
    # require "pry"; binding.pry
    reader.each {|data| array_helper(key) << klass.new(data)}
  end

  def array_helper(key)
    {items: @items_array,
     merchants: @merchants_array,
     invoices: @invoice_array,
     invoice_items: @invoice_item_array,
     customers: @customer_array,
     transactions: @transaction_array}[key]
  end
end
# require "pry"; binding.pry
