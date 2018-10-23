class ItemRepository
  attr_reader :items

  def initialize
    @items = []
  end

  def all
    @items
  end

  def add_item(item)
    @items << item
  end

  # def inspect
  # "#<#{self.class} #{@items.size} rows>"
  # end

end
