
class Item
  attr_reader :id, :name, :updated_at, :description, :unit_price, :created_at

  def initialize(row)
    @id = row[:id].to_i
    @name = row[:name]
    @updated_at = row[:updated_at]
    @description = row[:description]
    @unit_price = row[:unit_price]
    @created_at = row[:created_at]
  end
end
