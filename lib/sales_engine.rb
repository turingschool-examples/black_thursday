require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine
  attr_reader :item_repository,
              :from_csv,
              :merchant_store,
              :merchant_repository,
              :items,
              :merchants,
              :items_store
  def initialize
    # @item_repository = ItemRepository.new(self)
    # @merchant_repository = MerchantRepository.new
  end

  def from_csv(data)
    @item_repository = ItemRepository.new(self)
    @merchant_repository = MerchantRepository.new(self)
    @item_repository.create_item(data)
    @merchant_repository.create_merchant(data)
# binding.pry
  end

  def merchant(id)
    @merchant_repository.find_by_id(id)
  end

end
