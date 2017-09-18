require_relative 'invoice_item_repository'
require 'bigdecimal'
require 'time'

class InvoiceItem

  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :invoice_item_repository

  def initialize(invoice_item_repository, csv_info)
    @id = csv_info[:id].to_i
    @item_id = csv_info[:item_id].to_i
    @invoice_id = csv_info[:invoice_id].to_i
    @quantity = csv_info[:quantity]
    @unit_price = unit_price_to_dollars(csv_info[:unit_price])
    @created_at = Time.parse(csv_info[:created_at])
    @updated_at = Time.parse(csv_info[:updated_at])
    @invoice_item_repository = invoice_item_repository
  end

  def unit_price_to_dollars(unit_price)
    dollars = unit_price.to_f / 100
    BigDecimal.new(dollars, 5)
  end

end
