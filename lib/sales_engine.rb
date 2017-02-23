require './../black_thursday/lib/merchant_repository'
require './../black_thursday/lib/item_repository'


class SalesEngine

  attr_reader :merchants, :items

  def initialize(paths)
    @merchants = MerchantRepository.new(paths[:merchants])
    @items = ItemRepository.new(paths[:items])
  end

  def self.from_csv(data_paths)
    self.new(data_paths)
  end

end
