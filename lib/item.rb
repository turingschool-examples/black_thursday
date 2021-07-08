require_relative "../test/test_helper"

class Item
  attr_reader   :id,
                :name,
                :description,
                :unit_price,
                :created_at,
                :updated_at,
                :merchant_id,
                :unit_price_to_dollars,
                :parent

  def initialize(attributes = {}, parent = nil)
    @id           = attributes[:id]
    @name         = attributes[:name]
    @description  = attributes[:description]
    @unit_price   = attributes[:unit_price]
    @created_at   = attributes[:created_at]
    @updated_at   = attributes[:updated_at]
    @merchant_id  = attributes[:merchant_id]
    @parent = parent

    #id and merchant_id might not be given??
  end

  def unit_price_to_dollars
    BigDecimal.new(@unit_price).to_f
  end


end
