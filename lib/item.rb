class Item
  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at
  attr_reader   :id,
                :created_at,
                :merchant_id

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @description = attributes[:description]
    @unit_price = attributes[:unit_price]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
  end
end
