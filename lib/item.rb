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

  def unit_price
    @item_info[:unit_price]
  end

  def created_at
    @item_info[:created_at]
  end

  def updated_at
    @item_info[:updated_at]
  end

end
