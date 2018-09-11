require_relative "../lib/items_repo"
require_relative "../lib/merchant_repo"

class SalesEngine
  attr_reader :merchants,
              :items

  def self.from_csv(params)
    merchants = MerchantRepo.new(params[:merchants])
    items = ItemsRepo.new(params[:items])

    SalesEngine.new(merchants, items)
  end

  def initialize(merchants, items)
    @merchants = merchants
    @items = items
  end
end
