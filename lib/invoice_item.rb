  require 'bigdecimal'
  require 'time'
  require_relative '../lib/black_thursday_helper'

class InvoiceItem
  include BlackThursdayHelper
  attr_reader   :created_at,
                :item_id,
                :invoice_id

  attr_accessor :quantity,
                :unit_price,
                :updated_at,
                :id

  def initialize(params)
    @id = params[:id].to_i
    @item_id = params[:item_id].to_i
    @invoice_id = params[:invoice_id].to_i
    @quantity = params[:quantity].to_i
    params[:unit_price] = params[:unit_price].dup.insert(-3, '.') if params[:unit_price].is_a?(String)
    @unit_price = BigDecimal.new(params[:unit_price])
    @created_at = Time.parse(params[:created_at].to_s)
    @updated_at = Time.parse(params[:updated_at].to_s)
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

end
