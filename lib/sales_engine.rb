require 'CSV'
require_relative 'item_repository'
require_relative 'merchant_repository'
require 'pry'

class SalesEngine

  def self.from_csv(hash)
    SalesEngine.new(hash)
  end

  attr_reader :items,
              :merchants

  def initialize(hash)
    @items = ItemRepository.new(hash[:items], self)
    @merchants = MerchantRepository.new(hash[:merchants], self)
  end

  def fetch_merchant_id(merchant_id)
    pass_merchant_id(merchant_id)
  end

  def pass_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def fetch_items_merchant_id(merchant_id)
    pass_items_merchant_id(merchant_id)
  end

  def pass_items_merchant_id(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

end
