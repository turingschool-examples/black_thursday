class Item
  attr_reader :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent)
    @name = data[:name]
    @description = data[:description]
    @unit_price = data[:unit_price]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @parent = parent
  end
end
