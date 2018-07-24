# frozen_string_literal: true

require 'bigdecimal'

# Item class
class Item
  attr_reader :id,
              :created_at,
              :merchant_id

  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at

  def initialize(params)
    @id          = params[:id]
    @name        = params[:name]
    @description = params[:description]
    @unit_price  = params[:unit_price]
    @created_at  = params[:created_at]
    @updated_at  = params[:updated_at]
    @merchant_id = params[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
