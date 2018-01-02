require 'csv'
require './lib/item_repository'
require './lib/merchant_repository'

class SalesEngine

  def self.from_csv()
    @items = ItemRepository.new(self)
    @merchants = MerchantRepository.new(self)
  end


end


## given a hash with keys = objects, values = path to the objects
## t
##
