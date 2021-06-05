require_relative '../spec/spec_helper'

class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(paths)
    @items = ItemRepository.new(paths[:items])
    @merchants = MerchantRepository.new(paths[:merchants])
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
