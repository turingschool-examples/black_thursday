require_relative './items_repo'
require_relative './merchants_repo'
require_relative './invoices_repo'
require 'csv'

class SalesEngine
  attr_accessor :items,
                :merchants,
                :invoices

  def initialize(csv_files)
    @items = ItemRepo.new(csv_files[:items], self)
    @merchants = MerchantRepo.new(csv_files[:merchants], self)
    @invoices = InvoiceRepo.new(csv_files[:invoices], self)
  end

  def self.from_csv(csv_files)
    SalesEngine.new(csv_files)
  end

  def analyst
    SalesAnalyst.new(@items, @merchants, @invoices)
  end

  def find_items_by_id(id)
    @items.find_by_id(id)
  end

  def find_merchants_by_id(id)
    @merchants.find_by_id(id)
  end
end
