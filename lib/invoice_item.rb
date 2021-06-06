require 'CSV'
require 'bigdecimal'
require 'time'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :unit_price,
              :quantity,
              :created_at,
              :updated_at

  def initialize(item_data, repo)
    @id = item_data[:id].to_i
    @item_id = item_data[:item_id]
    @invoice_id = item_data[:invoice_id]
    @unit_price = BigDecimal(item_data[:unit_price]) / 100
    @quantity = item_data[:quantity].to_i
    @created_at = Time.parse(item_data[:created_at].to_s)
    @updated_at = Time.parse(item_data[:updated_at].to_s)
    @repo = repo
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
