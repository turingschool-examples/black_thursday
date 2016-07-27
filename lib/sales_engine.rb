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
    MerchantsRepo.new(@files[:merchants])
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

#se = SalesEngine.from_csv(files) # SalesEngine.new(files)
#se.merchants # -> MerchantsRepo.new(hash[:merchants])
# .all # -> .all
