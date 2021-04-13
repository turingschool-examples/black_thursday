require './lib/items_repo'
require './lib/merchants_repo'
require 'csv'

class SalesEngine

  def initialize(csv_files)
    @items_repo = ItemRepo.new(csv_files[:items])
    @merchant_repo = MerchantRepo.new(csv_files[:merchants])
  end

  def self.from_csv(csv_files)
    SalesEngine.new(csv_files)
  end
end
