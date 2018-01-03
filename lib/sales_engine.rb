require './lib/item_repository'
require './lib/merchant_repository'

class SalesEngine

  attr_reader :item_repository,
              :merchant_repository

  def initialize
    @item_repository = ItemRepository.new
    @merchant_repository = MerchantRepository.new
  end

  def self.from_csv(csv_file_hash)
    csv_file_hash
  end

end
