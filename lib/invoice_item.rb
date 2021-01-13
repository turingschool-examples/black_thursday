require 'bigdecimal'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :created_at,
              :quantity,
              :unit_price,
              :updated_at,
              :created_day

  def initialize(attributes)
    @id         = attributes[:id]
    @item_id    = attributes[:item_id]
    @invoice_id = attributes[:invoice_id]
    @quantity   = attributes[:quantity]
    @unit_price = attributes[:unit_price]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def update(attributes)
    @quantity   = attributes[:quantity] if attributes[:quantity]
    @unit_price = attributes[:unit_price] if attributes[:unit_price]
    @updated_at = Time.now
  end

  def created_day
    weekdays = {0 => :sunday,
                1 => :monday,
                2 => :tuesday,
                3 => :wednesday,
                4 => :thursday,
                5 => :friday,
                6 => :saturday,
              }
    weekdays[@created_at.wday]
  end

  def total_price
    @unit_price * @quantity
  end
end
