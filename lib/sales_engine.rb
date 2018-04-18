require './lib/merchant_repo'
require './lib/item_repo'
require './lib/invoice_repo'
require './lib/sales_relationships'
require './lib/load_file'

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

  def item_repo
    @item_repo ||= ItemRepo.new(LoadFile.load(path[:item_data]), self)
  end

  def merchant_repo
    @merchant_repo ||= MerchantRepo.new(LoadFile.load(path[:merchant_data]), self)
  end

  def invoice_repo
    @invoice_repo ||= InvoiceRepo.new(LoadFile.load(path[:invoice_data]),self)
  end
end