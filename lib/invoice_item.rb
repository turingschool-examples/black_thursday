class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(details)
    @id = details[:id]
    @item_id = details[:item_id]
    @invoice_id = details[:invoice_id]
    @quantity = details[:quantity]
    @unit_price = details[:unit_price]
    @created_at = details[:created_at]
    @updated_at = details[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price.to_f / 100
  end

  def update_id(id)
    return false if id.nil?
    @id = id
  end

  def update_quantity(quantity)
    return false if quantity.nil?
    @quantity = quantity
  end

  def update_unit_price(unit_price)
    return false if unit_price.nil?
    @unit_price = unit_price
  end

  def new_updated_at_time
    @updated_at = Time.now
  end
end
