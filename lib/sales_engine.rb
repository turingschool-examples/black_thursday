require  "./lib/item_repository"
require  "./lib/merchant_repository"
require "csv"
require "pry"

class SalesEngine

  attr_reader :items,
              :merchants

  def initialize(files_to_load)
      @items = ItemRepository.new(files_to_load[:items], self)
      @merchants = MerchantRepository.new(files_to_load[:merchants], self)
  end

  def self.from_csv(files_to_load)
      self.new(files_to_load)
  end
end
