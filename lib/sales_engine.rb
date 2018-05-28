require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine

  attr_reader :items, :merchants
  def initialize(data)
     @items ||= ItemRepository.new(data[:items])
     @merchants = MerchantRepository.new(data[:merchants])
  end

  def self.from_csv(data)
    new(data)
  end
end
