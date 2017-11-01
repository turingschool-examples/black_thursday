require_relative 'item_repository'
require_relative 'merchant_repository'
require 'csv'

class SalesEngine
  def self.from_csv(files)
    items = files[:items]
    merchants = files[:merchants]
    SalesEngine.new(items, merchants)
  end

  attr_reader :items, :merchants

  def initialize(items, merchants)
    @items = ItemRepository.new(items)
    @merchants = MerchantRepository.new(merchants)
  end


end
