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
  invoice_id - returns the invoice id
  credit_card_number - returns the credit card number
  credit_card_expiration_date - returns the credit card expiration date
  result - the transaction result
  created_at - returns a Time instance for the date the transaction was first created
  updated_at - returns a Time instance for the date the transaction was last modified
  We create an instance like this:

  t = Transaction.new({
    :id => 6,
    :invoice_id => 8,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
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
