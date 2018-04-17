
class InvoiceItem
  attr_reader :attributes


  def initialize(data)
    modify(data)
    @attributes = data
  end

  def modify(data)
    data[:id] = data[:id].to_i
    data[:item_id] = data[:item_id].to_i
    data[:invoice_id] = data[:invoice_id].to_i
    data[:quantity] = data[:quantity].to_i
    data[:unit_price] = BigDecimal.new(data[:unit_price]) / 100
    data[:created_at] = Time.parse(data[:created_at])
    data[:updated_at] = Time.parse(data[:updated_at])
    data
  end

  def id
    @attributes[:id]
  end

  def item_id
    @attributes[:item_id]
  end

  def invoice_id
    @attributes[:invoice_id]
  end

  def quantity
    @attributes[:quantity]
  end

  def unit_price
    @attributes[:unit_price]
  end

  def created_at
    @attributes[:created_at]
  end

  def updated_at
    @attributes[:updated_at]
  end

  def unit_price_to_dollars
    @attributes[:unit_price_to_dollars]
  end


end
