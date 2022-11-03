require 'csv'
require_relative './merchant_repository'
require_relative './item_repository'
require_relative './invoice_repository'
require_relative './invoice_item_repository'
require_relative './item'
require_relative './merchant'
require_relative './invoice'

class SalesEngine
  attr_reader :items, 
              :merchants, 
              :invoices,
              :invoice_items

  def initialize(data)
    repo_creation(data[:merchants], :merchants)
    repo_creation(data[:items], :items)
    repo_creation(data[:invoices], :invoices)
    repo_creation(data[:invoice_items], :invoice_items)
  end

  def self.from_csv(data)
    new(data)
  end

  def repo_creation(input_data, input_type)
    if input_type == :merchants 
      @merchants = MerchantRepository.new(thing_creation(input_data, input_type))
    elsif input_type == :items
      @items = ItemRepository.new(thing_creation(input_data, input_type))
    elsif input_type == :invoices
      @invoices = InvoiceRepository.new(thing_creation(input_data, input_type))
    elsif input_type == :invoice_items
      @invoice_items = InvoiceItemRepository.new(thing_creation(input_data, input_type))
    end
  end

  def thing_creation(second_data, second_type)
    data = CSV.open second_data, headers: true, header_converters: :symbol
      data.map do |row|
      thing_type(second_type, row)
    end
  end

  def thing_type(type, row)
    if type == :merchants
      Merchant.new(row)
    elsif type == :items
      Item.new(row)
    elsif type == :invoices
      Invoice.new(row)
    elsif type == :invoice_items
      InvoiceItem.new(row)
    end
  end

  def analyst
    SalesAnalyst.new(@merchants,@items,@invoices)
  end
end