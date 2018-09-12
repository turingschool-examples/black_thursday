module CustomerID
  def customer_id
    @attributes[:customer_id]
  end
end

module MerchantID
  def merchant_id
    @attributes[:merchant_id]
  end
end

module Status
  def status
    @attributes[:status]
  end
end

module Description
  def description
    @attributes[:description]
  end
end

module UnitPrice
  def unit_price
    @attributes[:unit_price]
  end
end

module UnitPriceToDollars
  def unit_price_to_dollars
    @attributes[:unit_price].to_f.round(2)
  end
end

module CreatedAt
  def created_at
    @attributes[:created_at]
  end
end

module UpdatedAt
  def updated_at
    @attributes[:updated_at]
  end
end
