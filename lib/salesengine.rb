require 'csv'
require './lib/merchantrepository'
require './lib/itemrepository'
require './lib/invoicerepository'
require './lib/item'
require './lib/merchant'
require './lib/invoice'

class SalesEngine
  attr_reader :items, :merchants, :invoices

  def initialize(data)
    @merchants = repo_creation(data[:merchants], :merchants)
    @items = repo_creation(data[:items], :items)
    @invoices = repo_creation(data[:invoices], :invoices)
  end

  def self.from_csv(data)
    new(data)
  end

  def repo_creation(input_data, input_type)
    
    if input_type == :merchants 
      MerchantRepository.new(thing_creation(input_data, input_type))
    elsif input_type == :items
      ItemRepository.new(thing_creation(input_data, input_type))
    elsif input_type == :invoices
      InvoiceRepository.new(thing_creation(input_data, input_type))
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
    end
  end

  def analyst
    SalesAnalyst.new(@merchants,@items,@invoices)
  end
end