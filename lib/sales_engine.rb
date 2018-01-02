require './lib/item_respository'
require './lib/merchant_repository'

class SalesEngine

  attr_reader :item_respository,
              :merchant_repository

  def initialize
    @item_respository = ItemRespository.new
    @merchant_repository = MerchantRepository.new
  end

  # def self.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
  #
  # end

end
