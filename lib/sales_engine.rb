require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'file_loader'

class SalesEngine
  attr_reader :merchants, :items

  def initialize(file_paths)
    @merchants = MerchantRepository.new(FileLoader.load_csv(file_paths[:merchants]))
    @items = ItemRepository.new(FileLoader.load_csv(file_paths[:items]))
  end

  def self.from_csv(file_paths)
    SalesEngine.new(file_paths)
  end

end
