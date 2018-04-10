require_relative 'merchant_repo'
require_relative 'item_repo'


class SalesEngine
  attr_accessor :items, :merchants

  def initialize()
    @items = ItemRepo.new
    @merchants = MerchantRepo.new
  end

  def self.from_csv(gtbwkejbn)
  end
end
