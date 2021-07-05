# Item
class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(item, parent = nil)
    @id = item[:id]
    @name = item[:name]
    @description = item[:description]
    @unit_price = item[:unit_price].to_f
    @created_at = item[:created_at]
    @updated_at = item[:updated_at]
  end
end
