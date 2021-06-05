require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'sales_analyst'

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

  def analyst
    SalesAnalyst.new(@item_repo, @merchant_repo, self)
  end

end
