require_relative './merchant_repository'
require_relative './item_repository'


class SalesEngine

  attr_reader :merchants, :items

  def initialize(paths)
    @merchants = MerchantRepository.new(paths[:merchants], self)
    @items = ItemRepository.new(paths[:items], self)
  end

  def self.from_csv(data_paths)
    new(data_paths)
  end

end
