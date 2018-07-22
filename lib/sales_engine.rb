require 'csv'
require_relative '../lib/item.rb'
require_relative '../lib/merchant.rb'

class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(csv_hash)
    @csv_hash = csv_hash
    @items = ItemRepository.new(csv_hash[:items])
    @merchants = MerchantRepository.new(csv_hash[:merchants])
  end

  def from_csv(csv_hash)
    SalesEngine.new(csv_hash)
  end
end
