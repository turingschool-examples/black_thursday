require "csv"
require_relative "item_repo"
require_relative "merchant_repo"

class SalesEngine

  def self.from_csv(files)
    SalesEngine.new(files)
  end

  def initialize(files)
    @files = files
  end

  def merchants
    @merchants = MerchantsRepo.new(@files[:merchants], self)
  end

  def items
    @items = ItemsRepo.new(@files[:items], self )
  end

  def find_merchant_by_item_id(merchant_id)
    @merchants.find_by_id(merchant_id)
  end
end

  # se = SalesEngine.new({merchant: filename})
  # se.merchants_repo.merchants
  #
  # se = SalesEngine.from_csv({merchant: filename})
  # se.merchants_repo.merchants

  def find_items_by_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

end
