
class Item


  def id
    # returns the integer id of the item
  end

  def name
    # returns the name of the item
  end

  def description
    # returns the description of the item
  end

  def unit_price
    # returns the price of the item formatted as a BigDecimal
  end

  def created_at
  # returns a Time instance for the date the item was first created
  end


  def updated_at
    # returns a Time instance for the date the item was last modified
  end

  def merchant_id
    # returns the integer merchant id of the item
  end

  def unit_price_to_dollars
    # returns the price of the item in dollars formatted as a Float
  end

end

i = Item.new({
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
})
