require_relative './items_repo'
require_relative './merchants_repo'
require_relative './sales_analyst'
require 'csv'

class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(csv_files)
    @items = ItemRepo.new(csv_files[:items])
    @merchants = MerchantRepo.new(csv_files[:merchants])
  end

  def self.from_csv(csv_files)
    SalesEngine.new(csv_files)
  end

  def self.analyst
    SalesAnalyst.new
  end
end
