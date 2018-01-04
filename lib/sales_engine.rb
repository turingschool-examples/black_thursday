require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine

  attr_reader :item_repository,
              :merchant_repository

  def initialize(csv_files)
    @item_repository = ItemRepository.new(csv_files[:items], self)
    @merchant_repository = MerchantRepository.new(csv_files[:merchants], self)
  end

  def self.from_csv(csv_files)
    SalesEngine.new(csv_files)
  end

  def find_item_by_merchant_id(id)
    item_repository.find_item(id)
  end

  def find_merchant_by_id(id)
    merchant_repository.find_merchant(id)
  end

end
