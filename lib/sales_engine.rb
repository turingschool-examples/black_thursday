require 'csv'
require_relative 'merchant_repository.rb'
require_relative 'item_repository.rb'


class SalesEngine
  attr_reader :items, :merchants
  def self.from_csv(hash)
    SalesEngine.new(hash)
  end

  def initialize(hash)
    @items = ItemRepository.new(hash[:items])
    @merchants = MerchantRepository.new(hash[:merchants])
  end
end
