class Merchant 
  attr_reader :id, :name

  def initialize(item, parent=nil)
    @id     = item[:id].to_i
    @name   = item[:name]
    @parent = parent
  end

  def items
    @parent.find_all_items_per_merchant(id)
  end
end
