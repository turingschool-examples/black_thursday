# frozen_string_literal: true

require 'bigdecimal'
require 'time'

# Item class
class Item
  attr_reader   :id,
                :created_at,
                :merchant_id

  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at

  def initialize(params)
    @id          = params[:id].to_i
    @name        = params[:name]
    @description = params[:description]
    @unit_price  = BigDecimal(params[:unit_price].dup.insert(-3, '.'))
    @created_at  = Time.parse(params[:created_at].to_s)
    @updated_at  = Time.parse(params[:updated_at].to_s)
    @merchant_id = params[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
