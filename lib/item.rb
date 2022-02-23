class Item
  attr_reader :item_info

  def initialize(item_info)
    @item_info = item_info
  end

  def id
    @item_info[:id]
  end

  def name
    @item_info[:name]
  end

  def description
    @item_info[:description]
  end

end
