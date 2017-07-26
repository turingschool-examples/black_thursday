require 'simplecov'
SimpleCov.start

require './lib/item_repository'
require './lib/merchant_repository'

class SalesEngine
  attr_reader :files,
              :items,
              :merchants

  def self.from_csv(csv_hash)
    SalesEngine.new(csv_hash)
  end

  def initialize(csv_hash)
    @items = ItemRepository.new(csv_hash[:items])
    @merchants = MerchantRepository.new(csv_hash[:merchants])
  end

end
