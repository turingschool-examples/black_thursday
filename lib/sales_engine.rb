require_relative '../spec/spec_helper'
require_relative '../module/incravinable'

class SalesEngine
  include Incravinable
  
  attr_reader :items,
              :merchants,
              :analyst

  def initialize(paths)
    @items = ItemRepository.new(paths[:items], self)
    @merchants = MerchantRepository.new(paths[:merchants], self)
    @analyst = SalesAnalyst.new(self)
  end

  def self.from_csv(paths)
    new(paths)
  end

  def all_merchants
    @merchants.all
  end

  def all_items
    @items.all
  end
end
