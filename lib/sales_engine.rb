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

  # def self.merchants
  #   @merchants
  # end
  #
  # def self.items
  #   @items
  # end



# temp_item.rb
#require 'minitest/mock'
#mock_se = Minitest::Mock.new
#mock_se.expect(:find_merchant_by_id, "merchant", ["merchant_id"])





  # require "pry"; binding.pry


#   items returns an instance of ItemRepository with all the item instances loaded

# merchants returns an instance of MerchantRepository with all the merchant instances loaded



  # def self.merchants
  #   @MerchantRepository
  # end

  # def self.items
  #   @ItemRepository = ItemRepository.new(true)
  # end
end
