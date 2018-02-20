class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent)
    @id = data[:id]
    @name = data[:name]
    @description = data[:description]
    @unit_price = data[:unit_price]
    @merchant_id = data[:merchant_id]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @parent = parent
  end

  def unit_price_to_dollars
    @unit_price.to_f / 100
  end

  def merchant
    @parent.pass_merchant_id_to_se(@merchant_id)
  end
end
