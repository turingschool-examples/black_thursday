require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine

  def initialize(paths)
    @item_repo = ItemRepository.new(paths[:items], self)
    @merchant_repo = MerchantRepository.new(paths[:merchants], self)
  end

  def self.from_csv(paths)
    new(paths)
  end

  def items
    @item_repo
  end

  def merchants
    @merchant_repo
  end

end
