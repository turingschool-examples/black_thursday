# sales_engine
require 'CSV'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'item'
require_relative 'merchant'
require_relative 'invoice'
require_relative 'sales_analyst'
require 'pry'

class SalesEngine
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def self.from_csv(data)
    new(data)
  end

  def merchants
    @merchants ||= MerchantRepository.new(data[:merchants])
  end

  def items
    @items ||= ItemRepository.new(data[:items])
  end

  def analyst
    SalesAnalyst.new(self)
  end

  def invoices
    @invoices ||= InvoiceRepository.new(data[:invoices])
  end
end
