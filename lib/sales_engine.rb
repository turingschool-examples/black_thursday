require_relative './merchant_repository'
require_relative './item_repository'

class SalesEngine
  attr_reader :merchants, :items
  def initialize(file_path_hash)
    @merchants = MerchantRepository.new(file_path_hash[:merchants])
    @items = ItemRepository.new(file_path_hash[:items])
  end

  def self.from_csv(file_path_hash)
    SalesEngine.new(file_path_hash)
  end

  def analyst
    SalesAnalyst.new(@merchants)
  end
end
