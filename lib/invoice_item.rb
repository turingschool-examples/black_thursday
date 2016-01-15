class InvoiceItem
  attr_reader :invoice_item
  attr_accessor :item, :invoice

  def initialize(invoice_item)
    @invoice_item = invoice_item
  end

  def item_id
    invoice_item[:item_id]
  end

  def id
    invoice_item[:id].to_i
  end

  def invoice_id
    invoice_item[:invoice_id].to_i
  end

  def created_at
    Time.parse(invoice_item[:created_at])
  end

  def updated_at
    Time.parse(invoice_item[:updated_at])
  end

  def quantity
    invoice_item[:quantity]
  end

  def unit_price
    invoice_item[:unit_price]
  end
end
