#item_repository
class ItemRepository
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def all
    @items
  end




end
