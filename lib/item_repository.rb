class ItemRepository

  def initialize (items, parent)
    @items = items
    @parent = parent
  end

  def all
    
  end


  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
  end
end
