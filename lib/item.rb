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
