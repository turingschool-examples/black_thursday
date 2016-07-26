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

  def find_items_by_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

end
