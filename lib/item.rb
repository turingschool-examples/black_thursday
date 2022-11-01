# This is an item held within the ItemRepository class
# All data is passed in through a single Hash
class Item
  def initialize(item)
    @id = item[:id]
    @name = item[:name]
    @description = item[:description]
    @unit_price = item[:unit_price]
    @created_at = item[:created_at]
    @updated_at = item[:updated_at]
    @merchant_id = item[:merchant_id]
  end
end
# Each item has the following methods: 
# 'id' 

# 'name'

# 'description'

# 'unit_price' - formatted as BigDecimal

# 'created_at' - relies on Time instance module

# 'updated_at' - same as above

# 'merchant_id'

# 'unit_price_to_dollars - returns the price of the item in dollars as Float

