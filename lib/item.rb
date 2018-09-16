require 'bigdecimal'
require 'time'
require_relative '../lib/black_thursday_helper'

class Item
  include BlackThursdayHelper
  attr_reader   :created_at,
                :merchant_id

  attr_accessor :id,
                :name,
                :description,
                :unit_price,
                :updated_at

  def initialize(params)
    @id = params[:id].to_i
    @name = params[:name]
    @description = params[:description]
    @unit_price = BigDecimal.new(params[:unit_price].to_f/100,4)
    @created_at = Time.parse(params[:created_at].to_s)
    @updated_at = Time.parse(params[:updated_at].to_s)
    @merchant_id = params[:merchant_id].to_i
    updated_at
    created_at
  end

  def updated_at
    Time.parse(@updated_at) 
  end

  def created_at
    Time.parse(@created_at)
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

end
