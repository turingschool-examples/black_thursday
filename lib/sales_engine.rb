require  "./lib/item_repository"
require  "./lib/merchant_repository"
require "csv"
require "pry"

class SalesEngine

  def self.from_csv(files_to_load)
      @items = CSV.open(files_to_load[:items])
      @merchants = CSV.open(files_to_load[:merchants])
      self
  end

  def self.items
    item_repository ||= ItemRepository.new(@items)
  end

  def self.merchants
    merchant_repository ||= MerchantRepository.new(@merchants)
  end

end
