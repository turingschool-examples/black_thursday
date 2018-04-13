require 'time'
# Element module for object type classes
module Element
  attr_reader :attributes

  def id
    @attributes[:id].to_i
  end

  def name
    @attributes[:name]
  end

  def unit_price
    price = @attributes[:unit_price].to_i
    BigDecimal.new(price) / 100
  end

  def created_at
    time = @attributes[:created_at]
    if time.class == Time
      time
    else
    Time.parse(@attributes[:created_at])
    end
  end

  def updated_at
    time = @attributes[:updated_at]
    if time.class == Time
      time
    else
    Time.parse(@attributes[:updated_at])
    end
  end

  def merchant_id
    @attributes[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @attributes[:unit_price].to_f / 100
  end

  def merchant
    @engine.merchants.find_by_id(merchant_id)
  end

  def invoices
    @engine.invoices.find_all_by_merchant_id(id)
  end

  def invoice_id
    @attributes[:invoice_id].to_i
  end

  def customers
    invoices.map do |invoice|
      @engine.customers.find_by_id(invoice.customer_id)
    end.uniq
  end

  def items
    invoice_items = @engine.invoice_items.find_all_by_invoice_id(id)
    invoice_items.map do |invoice_item|
      @engine.items.find_by_id(invoice_item.item_id)
    end.uniq
  end

  def transactions
    @engine.transactions.find_all_by_invoice_id(id)
  end

  def invoice
    @engine.invoices.find_by_id(invoice_id)
  end

  def update(states)
    attributes[:name] = states[:name] if states[:name]
    attributes[:unit_price] = states[:unit_price] * 100 if states[:unit_price]
    attributes[:updated_at] = Time.now
    attributes[:invoice_id] = states[:invoice_id] if states[:invoice_id]
  end
end
