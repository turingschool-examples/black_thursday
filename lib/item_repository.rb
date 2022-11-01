class ItemRepository
  attr_reader :items

  def initialize
    @items = []
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find do |item|
      #if the ids match
      item.id == id
    end
  end
end