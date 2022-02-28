require_relative "merchant_repository"
require_relative 'item_repository'
require_relative 'item'
require_relative 'merchant'
require_relative 'sales_analyst'
require_relative 'invoice_item'
require_relative 'invoice_item_repository'
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
      engine.file_reader(filepath, filename)
    end
    engine
  end
  def merchants
    MerchantRepository.new(@merchants_array)
  end
  def items
    ItemRepository.new(@items_array)
  end

  def invoices
    InvoiceRepository.new(@invoice_array)
  end
  def invoice_items
    InvoiceItemRepository.new(@invoice_items_array)
  end
  def customers
    CustomerRepository.new(@customer_array)
  end
  def transactions
    TransactionRepository.new(@transaction_array)
  end
  def file_reader(filepath, key)
    reader = CSV.open(filepath, headers: true, header_converters: :symbol)
    reader.each {|data| instantiator(key, data)}
  end
  def key_converter(key)
    {items: {array: @items_array, klass: Item},
     merchants: {array: @merchants_array, klass: Merchant},
     invoices: {array: @invoice_array, klass: Invoice},
     invoice_items: {array: @invoice_item_array, klass: InvoiceItem},
     customers: {array: @customer_array, klass: Customer},
     transactions: {array: @transaction_array, klass: Transaction}
     }[key]
  end
  def instantiator(key, data)
    key_converter(key)[:array] << key_converter(key)[:klass].new(data)
  end

  def analyst
    SalesAnalyst.new
  end
end
# require "pry"; binding.pry
