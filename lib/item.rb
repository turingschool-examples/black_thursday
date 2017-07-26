require 'bigdecimal'
class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(data, sales_engine)
    @sales_engine = sales_engine
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price = BigDecimal.new((data[:unit_price].to_i)/100, 4)
    @merchant_id = data[:merchant_id].to_i
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
  end

  def merchant
    @sales_engine.merchants.find_by_id(self.merchant_id)
  end
end
