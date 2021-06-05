require_relative '../spec/spec_helper'

class SalesEngine
  attr_reader :item_repo,
              :merchants

  def initialize(paths)
    @item_repo = ItemRepository.new(paths[:items])
    @merchants = MerchantRepository.new(paths[:merchants])
  end

  def self.from_csv(paths)
    new(paths)
  end

  def all_merchants
    @merchants.all
  end
end
