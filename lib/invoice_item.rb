class InvoiceItem
  attr_reader :invoice_item

  def initialize(invoice_item, invoice_item_repo)
    @invoice_item = invoice_item
    @invoice_item_repo = invoice_item_repo
  end

  def id
    invoice_item.fetch(:id).to_i
  end

  def item_id
    invoice_item.fetch(:item_id).to_i
  end

  def invoice_id
    invoice_item.fetch(:invoice_id).to_i
  end

  def quantity
    invoice_item.fetch(:quantity)
  end

  def unit_price
    BigDecimal.new(invoice_item.fetch(:unit_price).to_i)/100.0
  end

  def created_at
    Time.parse(invoice_item.fetch(:created_at))
  end

  def updated_at
    Time.parse(invoice_item.fetch(:updated_at))
  end

  def unit_to_dollar
    unit_price.to_f
  end

  def total
    unit_to_dollar * quantity.to_i
  end
end
