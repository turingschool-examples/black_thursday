require "./lib/item_repo"
require "./lib/merchant_repo"
require 'pry'


class SalesEngine
  attr_reader :items,
              :merchants

  def self.from_csv(directory)
    # item_filename = directory[:items]
    # merchant_filename = directory[:merchants]

    SalesEngine.new(directory)
  end

  def initialize(directory)
    @items      = ItemRepository.new(self, directory[:items])
    @merchants  = MerchantRepository.new(self, directory[:merchants])
  end

  def find_merchant(id)
    merchants.find_by_id(id)
  end

  def find_items(id)
    items.find_by_id(id)
  end

end
