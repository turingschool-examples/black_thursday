require_relative './merchant_repo'
require_relative './item_repo'


class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(data)
    @merchants = MerchantRepository.new(data[:merchants], self)
    @items = ItemRepository.new(data[:items])
  end

  def self.from_csv(data)
    new(data)
  end
end
