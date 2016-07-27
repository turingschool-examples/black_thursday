class Item
  attr_reader :id,
              :name

  def initialize(item) #, item_repository)
    @id = item[:id]
    @name = item[:name]
    @description = item[:description]
    @unit_price = item[:unit_price]
    @created_at = item[:created_at]
    @updated_at = item[:updated_at]
    @merchant_id = item[:merchant_id]
    @unit_price_to_dollars = item[:unit_price_to_dollars]
    # @item_repository = item_repository
  end
end


id - returns the integer id of the item

name - returns the name of the item

description - returns the description of the item

unit_price - returns the price of the item formatted as a BigDecimal

created_at - returns a Time instance for the date the item was first created

updated_at - returns a Time instance for the date the item was last modified

merchant_id - returns the integer merchant id of the item

unit_price_to_dollars - returns the price of the item in dollars formatted as a Float

We create an instance like this:
