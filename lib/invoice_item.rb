# frozen_string_literal: true

require 'calculable'

# This is the invoice_item class
class InvoiceItem
  include Calculable
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity

  def initialize(data, repo)
    @id = data[:id].to_i
    @item_id = data[:item_id].to_i
    @invoice_id = data[:invoice_id].to_i
    @quantity = data[:quantity]
    @unit_price = data[:unit_price]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @invoice_item_repo = repo
  end

  def unit_price
    BigDecimal(price_converter(@unit_price))
  end

  def unit_price_to_dollars
    price_converter(@unit_price).to_f
  end

  def created_at
    return Time.parse(@created_at) if @created_at.is_a? String

    @created_at
  end

  def updated_at
    return Time.parse(@updated_at) if @updated_at.is_a? String

    @updated_at
  end

  def update(data)
    @quantity = data[:quantity]
    @unit_price = data[:unit_price]
    @updated_at = Time.now
  end
end
