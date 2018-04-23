# frozen_string_literal: true

require_relative 'merchant_repo'
require_relative 'item_repo'
require_relative 'invoice_repo'
require_relative 'sales_relationships'
require_relative 'load_file'

# ties together all repos
class SalesEngine
  include SalesRelationships
  attr_reader :path
  def initialize(path)
    @path = path
  end

  def self.from_csv(path)
    SalesEngine.new(path)
  end

  def analyst
    SalesAnalyst.new(self)
  end

  def items
    @items ||= ItemRepo.new(LoadFile.load(@path[:items]), self)
  end

  def merchants
    @merchants ||= MerchantRepo.new(LoadFile.load(@path[:merchants]), self)
  end

  def invoices
    @invoices ||= InvoiceRepo.new(LoadFile.load(@path[:invoices]), self)
  end
end
