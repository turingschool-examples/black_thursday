require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class SalesEngine
  attr_reader :merchants,
              :items

  def initialize(load_paths)
    @merchants = MerchantRepository.new(load_paths[:merchants], self)
    @items     = ItemRepository.new(load_paths[:items], self)
  end

  def self.from_csv(load_paths)
    self.new(load_paths)
  end

  def find_merchant_by_item_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def find_items_by_merchant_id(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end
end





# temp_item.rb
#require 'minitest/mock'
#mock_se = Minitest::Mock.new
#mock_se.expect(:find_merchant_by_id, "merchant", ["merchant_id"])
