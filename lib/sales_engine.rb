require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine

  attr_reader :item_repository,
              :merchant_repository

  def initialize(items, merchants)
    @item_repository = ItemRepository.new(items, self)
    @merchant_repository = MerchantRepository.new(merchants, self)
  end

  def self.from_csv(csv_files)
    SalesEngine.new(csv_files[:items], csv_files[:merchants])
  end

  

end
