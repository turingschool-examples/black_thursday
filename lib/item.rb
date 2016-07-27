require 'bigdecimal'
require 'time'
require_relative '../lib/type_conversion'

class Item

  include TypeConversion
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :parent_repo

  def initialize(datum, parent_repo = nil)
    @id = datum[:id]
    @name = datum[:name]
    @description = datum[:description]
    @unit_price = convert_to_big_decimal(datum[:unit_price])
    @merchant_id = datum[:merchant_id]
    @created_at = Time.parse(datum[:created_at])
    @updated_at = Time.parse(datum[:updated_at])
    @parent_repo = parent_repo
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def merchant
    parent_repo.pass_to_engine(@merchant_id)
  end

end
