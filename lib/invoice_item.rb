  require 'bigdecimal'
  require 'time'
  require_relative '../lib/black_thursday_helper'

class InvoiceItem
  include BlackThursdayHelper
  attr_reader   :created_at,
                :id,
                :item_id

  attr_accessor :quantity,
                :unit_price,
                :updated_at

  def initialize(params)
    @id = params[:id].to_i
    @item_id = params[:item_id]
    @quantity = params[:quantity]
    @unit_price = BigDecimal.new(params[:unit_price].to_f/100,4)
    @created_at = Time.parse(params[:created_at].to_s)
    @updated_at = Time.parse(params[:updated_at].to_s)
  end
end
