require 'bigdecimal'

class Item

  attr_reader :id,
              :name,
              :description,
              :merchant_id,
              :unit_price,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent)
    @id           = data[:id].to_i
    @name         = data[:name]
    @description  = data[:description]
    @merchant_id  = data[:merchant_id].to_i
    @unit_price   = data[:unit_price]
    @created_at   = data[:created_at]
    @updated_at   = data[:updated_at]
    @parent       = parent
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def merchant
    parent.call_sales_engine_merchants(merchant_id)
  end

end
