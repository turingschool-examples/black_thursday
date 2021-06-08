require_relative '../spec/spec_helper'
require_relative '../module/incravinable'

class SalesEngine
  include Incravinable

  attr_reader :items,
              :merchants,
              :invoices,
              :analyst

  def initialize(paths)
    @items = ItemRepository.new(paths[:items], self)
    @merchants = MerchantRepository.new(paths[:merchants], self)
    @invoices = InvoiceRepository.new(paths[:invoices], self)
    @analyst = SalesAnalyst.new(self)
  end

  def self.from_csv(paths)
    new(paths)
  end

  def all_merchants
    @merchants.all
  end

  def all_items
    @items.all
  end

  def all_invoices
    @invoices.all
  end
end
