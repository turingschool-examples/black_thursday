require 'time'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(data)
    @id         = data[:id].to_i
    @item_id    = data[:item_id].to_i
    @invoice_id = data[:invoice_id].to_i
    @quantity   = data[:quantity].to_i
    @unit_price = BigDecimal(data[:unit_price].to_f / 100, 5)
    @created_at = update_time(data[:created_at].to_s)
    @updated_at = update_time(data[:updated_at].to_s)
  end

  def update_time(time)
    if time.nil?
      Time.now
    elsif time.empty?
      Time.now
    else
      Time.parse(time)
    end
  end

  def update(attributes)
    @quantity = attributes[:quantity] unless attributes[:quantity].nil?
    @unit_price  = BigDecimal(attributes[:unit_price]) unless attributes[:unit_price].nil?
    @updated_at  = update_time('')
  end

  def unit_price_to_dollars
    unit_price.to_f
  end
end
