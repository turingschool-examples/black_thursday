require_relative './merchant_repo'
require_relative './item_repo'

class SalesEngine

  attr_reader :merchants,
              :items
  def initialize(file_path)
    @merchants = MerchantRepo.new(file_path[:merchants], self)
    @items     = ItemRepo.new(file_path[:items], self)
  end

  def self.from_csv(file_path)
    SalesEngine.new(file_path)
  end

  def find_merchant_by_merchant_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def find_items_by_merchant_id(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def all_merchants
    @merchants.all.count
  end

  def all_items
    @items.all.count
  end
end
