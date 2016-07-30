require_relative  "../lib/item_repository"
require_relative  "../lib/merchant_repository"
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

  def find_items_by_merchant_id(merchant_id_input)
    items.find_all_by_merchant_id(merchant_id_input)
  end
  

end
