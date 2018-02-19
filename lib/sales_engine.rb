require_relative './item_repository'
class SalesEngine
  def self.from_csv(files)
    SalesEngine.new(files)
  end

  def initialize(files)
    @item_repo = ItemRepository.new(files[:items])
  end
end
