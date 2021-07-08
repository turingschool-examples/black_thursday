require 'pry'
require_relative "item_repository"
require_relative "merchant_repository"

class SalesEngine

  attr_accessor   :items,
                  :merchants

  def initialize
    @items      = ItemRepository.new(self)
    @merchants  = MerchantRepository.new(self)
  end

  def self.from_csv(repo)
    items_CSV = repo[:items]
    merchants_CSV = repo[:merchants]

    se = SalesEngine.new
    se.items.populate(items_CSV)
    se.merchants.populate(merchants_CSV)
    return se
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def find_merchant_by_id(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

end
