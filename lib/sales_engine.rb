require_relative '../lib/merchant_repo'
require_relative '../lib/item_repo'

class SalesEngine
  def self.from_csv(file_path)
    @items_file     = file_path[:items]
    @merchants_file = file_path[:merchants]
    self
  end

  def self.merchants
    MerchantRepo.new(@merchant_file)
  end

  def self.items
    ItemRepo.new(@items_file)
  end
end
