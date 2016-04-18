class Item
  attr_reader :id, :name, :description, :merchant_id

  def initialize(item_hash = {})
    @name = item_hash.fetch(:name)
    @description = item_hash.fetch(:description)
    @id = item_hash.fetch(:id)
    @merchant_id = item_hash.fetch(:merchant_id)
    @created_at = item_hash.fetch(:created_at)
    @updated_at = item_hash.fetch(:updated_at)
    # @unit_price = item_hash.fetch(:unit_price)
  end
end

# The Item instance offers the following methods:
# unit_price - returns the price of the item formatted as a BigDecimal
# created_at - returns a Time instance for the date the item was first created
# updated_at - returns a Time instance for the date the item was last modified
# merchant_id - returns the integer merchant id of the item
# It also offers the following method:
#
# unit_price_to_dollars - returns the price of the item in dollars formatted as a Float
# We create an instance like this:
