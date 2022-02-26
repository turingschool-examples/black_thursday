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
    reader.each {|data| key_converter(key)[:array] << key_converter(key)[:klass].new(data)}
  end

  def key_converter(key)
    {items: {array: @items_array, klass: Item},
     merchants: {array: @merchants_array, klass: Merchant}
     # invoices: {array: @invoice_array, klass: Invoice},
     # invoice_items: {array: @invoice_item_array, klass: InvoiceItem},
     # customers: {array: @customer_array, klass: Customer},
     # transactions: {array: @transaction_array, klass: Transaction}
     }[key]
  end

  # def class_converter(key)
  #   {items: Item,
  #    merchants: Merchant,
  #    # invoices: Invoice,
  #    # invoice_item: InvoiceItem,
  #    # customers: Customer,
  #    # transactions: Transaction
  #    }[key]
  # end
end
# require "pry"; binding.pry
