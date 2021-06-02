require './item_repository'
require 'CSV'

class SalesEngine
  
  def initialize(library)
    @item_repo = ItemRepository.new(library[:items], self)
    # @merchant_repo = MerchantRepository.new(paths[:merchants])
  end

  # def self.from_csv(paths)
  #   new(paths)
  # end
end
