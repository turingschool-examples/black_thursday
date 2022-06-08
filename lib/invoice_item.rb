require 'time'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :created_at

  attr_accessor :quantity,
                :unit_price,
                :updated_at

  def initialize(data_hash)
    @id = data_hash[:id].to_i
    @item_id = data_hash[:item_id]
    @invoice_id = data_hash[:invoice_id].to_i
    @quantity = data_hash[:quantity].to_i
    @unit_price = BigDecimal(data_hash[:unit_price].to_f / 100,4)
    @created_at = Time.parse(data_hash[:created_at])
    @updated_at = Time.parse(data_hash[:updated_at])
  end

  def unit_price_to_dollars
    @unit_price.to_f.round(2)
  end
end
