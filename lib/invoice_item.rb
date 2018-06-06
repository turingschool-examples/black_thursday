
class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(attributes)
    @id = attributes[:id].to_i
    @item_id = attributes[:item_id].to_i
    @invoice_id = attributes[:invoice_id].to_i
    @quantity = attributes[:quantity].to_i
    @unit_price = attributes[:unit_price]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
  end

  def update_quantity(num)
    @quantity = num
  end

  def update_price(float)
    if float == nil
      @unit_price
    else
      @unit_price = BigDecimal(float, float.to_s.length - 1)
    end
  end

  def update_updated_at(time)
    @updated_at = time
  end
end
