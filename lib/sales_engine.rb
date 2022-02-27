require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'sales_analyst'
require 'pry'

class SalesEngine
  attr_accessor :items, :merchants, :hash, :invoices
  def initialize(items, merchants, invoices)
    @items = items
    @merchants = merchants
    @invoices = invoices
  end

  def self.from_csv(info)
    @items = ItemRepository.new(info[:items])
    @merchants = MerchantRepository.new(info[:merchants])
    @invoices = InvoiceRepository.new(info[:invoices])
    new(@items, @merchants, @invoices)
  end

  def analyst
    SalesAnalyst.new(@merchants, @items, @invoices)
  end


end
