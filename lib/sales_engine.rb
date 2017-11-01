require "./lib/item_repo"
require "./lib/merchant_repo"
require 'pry'


class SalesEngine
  attr_reader :items,
              :merchants

  def self.from_csv(directory)
    item_filename = directory[:items]
    merchant_filename = directory[:merchants]

    SalesEngine.new(item_filename, merchant_filename)
  end

  def initialize(item_filename, merchant_filename)
    @items      = ItemRepository.new(self,item_filename)
    @merchants  = MerchantRepository.new(self, merchant_filename)
  end


  # def merchant(id)
  #   merchant_repository.find_by_id(id)
  # end
end
