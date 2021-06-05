require_relative '../spec/spec_helper'

class SalesEngine
  # attr_reader :item_repo,
  #             :merchant_repo

  def initialize(paths)
    @item_repo = ItemRepository.new(paths[:items])
    @merchant_repo = MerchantRepository.new(paths[:merchants])
  end

  def self.from_csv(paths)
    new(paths)
  end
end
