require_relative './merchant_repo'
require_relative './item_repo'


class SalesEngine
  attr_reader :items

  def initialize(data)
    @items = data[:items]
    @merchant_repo = MerchantRepository.new(data[:merchants], self)
    @item_repo = ItemRepository.new(data[:items])
  end

  def self.from_csv(data)
    new(data)
  end

  def merchants
    @merchant_repo.build_merchants
  end
end
