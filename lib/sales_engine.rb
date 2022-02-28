require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'customer_repository'
require_relative 'sales_analyst'
require 'pry'

class SalesEngine
  attr_accessor :items, :merchants, :hash, :invoices, :customers
  def initialize(items, merchants, invoices, customers)
    @items = items
    @merchants = merchants
    @invoices = invoices
    @customers = customers
  end

  def self.from_csv(info)
    @items = ItemRepository.new(info[:items])
    @merchants = MerchantRepository.new(info[:merchants])
    @invoices = InvoiceRepository.new(info[:invoices])
    @customers = CustomerRepository.new(info[:customers])
    new(@items, @merchants, @invoices, @customers)

  end

  def analyst
    SalesAnalyst.new(@merchants, @items, @invoices, @customers)
  end


end
