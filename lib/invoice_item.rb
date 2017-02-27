class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id
  def initialize(item, parent)
    @id = item[:id].to_i
    @name = item[:name]
    @description = item[:description]
    @unit_price = BigDecimal.new(item[:unit_price])/100
    @merchant_id = item[:merchant_id].to_i
    @created_at = item[:created_at]
    @updated_at = item[:updated_at]
    @parent = parent
  end

  id - returns the integer id
  item_id - returns the item id
  invoice_id - returns the invoice id
  quantity - returns the quantity
  unit_price - returns the unit_price
  created_at - returns a Time instance for the date the invoice item was first created
  updated_at - returns a Time instance for the date the invoice item was last modified
  It also offers the following method:

  unit_price_to_dollars - returns the price of the invoice item in dollars formatted as a Float
  We create an instance like this:

  ii = InvoiceItem.new({
    :id => 6,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => BigDecimal.new(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
  })

  def unit_price_to_dollars
    ("%.2f" % @unit_price).to_f
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

  def merchant
    @parent.parent.merchants.find_by_id(@merchant_id)
  end
end
