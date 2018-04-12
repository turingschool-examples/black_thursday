require 'time'
# Element module for object type classes
module Element
  attr_accessor :attributes

  def id
    @attributes[:id].to_i
  end

  def name
    @attributes[:name]
  end

  def description
    @attributes[:description]
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

  def customer_id
    @attributes[:customer_id].to_i
  end

  def status
    @attributes[:status].to_sym
  end

  def merchant
    @engine.merchants.find_by_id(merchant_id)
  end

  def invoices
    @engine.invoices.find_all_by_merchant_id(id)
  end

  def item_id
    @attributes[:item_id].to_i
  end

  def invoice_id
    @attributes[:invoice_id].to_i
  end

  def quantity
    @attributes[:quantity].to_i
  end

  def credit_card_number
    @attributes[:credit_card_number].to_i
  end

  def credit_card_expiration_date
    @attributes[:credit_card_expiration_date]
  end

  def result
    @attributes[:result]
  end

  def first_name
    @attributes[:first_name]
  end

  def last_name
    @attributes[:last_name]
  end

  def is_paid_in_full?
    transactions = @engine.transactions.find_all_by_invoice_id(id)
    transactions.any? do |transaction|
      transaction.result == 'success'
    end
  end

  def total
    invoice_items = @engine.invoice_items.find_all_by_invoice_id(id)
    total = 0
    invoice_items.each do |invoice_item|
      total += invoice_item.unit_price * invoice_item.quantity
    end
    total
  end

  def customers
    map = invoices.map do |invoice|
      if invoice.is_paid_in_full?
        @engine.customers.find_by_id(invoice.customer_id)
      else
        nil
      end
    end.compact
    # require 'pry'; binding.pry
  end
end
