class Item
  attr_accessor     :id,
                    :name,
                    :description,
                    :unit_price,
                    :created_at,
                    :updated_at,
                    :unit_price_to_dollars

  def initialize(item_attributes)
    @id = item_attributes[:id]
    @name = item_attributes[:name]
    @description = item_attributes[:description]
    @unit_price = item_attributes[:unit_price]
    @created_at = item_attributes[:created_at]
    @updated_at = item_attributes[:updated_at]
    @unit_price_to_dollars = item_attributes[:unit_price].to_f
  end
end
