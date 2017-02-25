require 'bigdecimal'
require 'time'
require 'pry'

class Item

  attr_reader :name, :id, :description, :unit_price, :created_at, :updated_at, :merchant_id, :sales_engine

  def initialize(params, sales_engine)
    @name = params[:name]
    @id = params[:id].to_i
    @description = params[:description]
    @unit_price = unit_price_to_dollars(params[:unit_price])
    @created_at = Time.parse(params[:created_at])
    @updated_at = Time.parse(params[:updated_at])
    @merchant_id = params[:merchant_id].to_i # test coverage for this
    @sales_engine = sales_engine
  end

  def unit_price_to_dollars(price)
    BigDecimal.new(price) / 100
  end

end
