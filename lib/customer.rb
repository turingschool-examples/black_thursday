class Customer
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

:id - returns the integer id
:first_name - returns the first name
:last_name - returns the last name
:created_at - returns a Time instance for the date the customer was first created
:updated_at - returns a Time instance for the date the customer was last modified

We create an instance like this:

c = Customer.new({
  :id => 6,
  :first_name => "Joan",
  :last_name => "Clarke",
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
