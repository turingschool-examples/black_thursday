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
    @merchant_repository = MerchantRepository.new
    # @items_store = []
    # @merchant_store = []
    # @items = data[:items]
    # @merchants = data[:merchants]
    # item_search =  CSV.foreach @items, headers: true, header_converters: :symbol do |row|
    #   @items_store << row
    # en
    @item_repository.create_item(data)
    @merchant_repository.create_merchant(data)

    #
    # mr = MerchantRepository.new
    # binding.pry
    # mr.create_merchant(data[:merchants])
  end

  def merchant(id)
    @merchant_repository.find_by_id(id)
  end

end
