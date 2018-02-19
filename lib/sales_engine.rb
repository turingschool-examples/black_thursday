require_relative './item_repository'
class SalesEngine
  attr_reader :items
  def self.from_csv(files)
    SalesEngine.new(files)
  end

  def initialize(files)
    @items = ItemRepository.new(files[:items])
  end
end
