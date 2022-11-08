# frozen_string_literal: true

require 'calculable'
require 'timeable'

# This is the invoice_item class
class InvoiceItem
  include Calculable, Timeable
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :created_time,
              :updated_time

  def initialize(data, repo)
    @id = data[:id].to_i
    @item_id = data[:item_id].to_i
    @invoice_id = data[:invoice_id].to_i
    @quantity = data[:quantity].to_i
    @unit_price = data[:unit_price]
    @created_time = data[:created_at]
    @updated_time = data[:updated_at]
    @invoice_item_repo = repo
  end

  def unit_price
    BigDecimal(price_converter(@unit_price))
  end

  def unit_price_to_dollars
    price_converter(@unit_price).to_f
  end

  def update(data)
    @quantity = data[:quantity]
    @unit_price = data[:unit_price]
    @updated_time = Time.now
  end
end
