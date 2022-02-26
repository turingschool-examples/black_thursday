require_relative "merchant_repository"
require_relative 'item'
require_relative 'merchant'
require 'csv'
class SalesEngine
  attr_reader :items_array, :merchants_array, :files
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
    engine.files.each do |filename, filepath|
      engine.file_helper(filepath, filename)
    end
    engine
  end
  def merchants
    MerchantRepository.new(@stash)
  end
  def items
    ItemRepository.new(@stash)
  end

  def file_helper(filepath, key)
    reader = CSV.open(filepath, headers: true, header_converters: :symbol)
    reader.each {|data| array_finder(key) << class_converter(key)}
  end

  def array_finder(key)
    {items: @items_array,
     merchants: @merchants_array,
     invoices: @invoice_array,
     invoice_items: @invoice_item_array,
     customers: @customer_array,
     transactions: @transaction_array}[key]
  end

  def class_converter(key)
    {items: Item,
     merchants: Merchant,
     # invoices: Invoice,
     # invoice_item: InvoiceItem,
     # customers: Customer,
     # transactions: Transaction
     }[key]
  end
end
# require "pry"; binding.pry
