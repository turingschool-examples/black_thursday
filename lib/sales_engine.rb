require 'time'
require 'CSV'
require_relative "../lib/items_repo"
require_relative "../lib/merchant_repo"

class SalesEngine
  attr_reader :merchants,
              :items
  def initialize(merchants, items)
    @merchants = MerchantRepo.new(merchants)
    @items = ItemsRepo.new(items)
  end

  def self.from_csv(params)
    merchants =  params[:merchants]
    items =   params[:items]
    SalesEngine.new(merchants, items)
  end
end
