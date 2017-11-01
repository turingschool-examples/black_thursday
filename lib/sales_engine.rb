require './lib/item_repository'
require './lib/merchant_repository'
# require './lib/merchant_repo'

class SalesEngine

  attr_reader :item_repository, :merchant_repository

  def initialize(items_file, merchants_file)
    @item_repository = ItemRepository.new(items_file, self)
    @merchant_repository = MerchantRepository.new(merchants_file, self)
  end

  def self.from_csv(files)
    items_file = files[:items]
    merchants_file = files[:merchants]
      SalesEngine.new(items_file, merchants_file)
  end

  def merchant(id)
    merchant_repository.find_by_id(id)
  end

end
