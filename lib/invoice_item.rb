class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price

  def initialize(details)
    @id = details[:id].to_i
    @item_id = details[:item_id].to_i
    @invoice_id = details[:invoice_id].to_i
    @quantity = details[:quantity]
    @unit_price = BigDecimal(details[:unit_price]) / 100
    @created_at = details[:created_at]
    @updated_at = details[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def update_id(id)
    return false if id.nil?

    @id = id
  end

  def update_quantity(quantity)
    @quantity = quantity unless quantity.nil?
  end

  def update_unit_price(unit_price)
    @unit_price = unit_price unless unit_price.nil?
  end

  def new_updated_at_time
    @updated_at = Time.now
  end

  def created_at
    return @created_at if @created_at.instance_of?(Time)

    Time.parse(@created_at)
  end

  def updated_at
    return @updated_at if @updated_at.instance_of?(Time)

    Time.parse(@updated_at)
  end
end
