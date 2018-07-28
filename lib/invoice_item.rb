# frozen_string_literal: true

require 'time'

# InvoiceItem class
class InvoiceItem
  attr_reader   :id,
                :item_id,
                :invoice_id,
                :created_at

  attr_accessor :quantity,
                :unit_price,
                :updated_at

  def initialize(params)
    @id           = params[:id].to_i
    @item_id      = params[:item_id].to_i
    @invoice_id   = params[:invoice_id].to_i
    @quantity     = params[:quantity].to_i
    @unit_price   = BigDecimal(params[:unit_price].dup.insert(-3, '.'))
    @created_at   = Time.parse(params[:created_at].to_s)
    @updated_at   = Time.parse(params[:updated_at].to_s)
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
