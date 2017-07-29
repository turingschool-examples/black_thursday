class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :mr

  def initialize(id, name, created_at, updated_at, mr)
    @id = id
    @name = name
    @created_at = created_at
    @updated_at = updated_at
    @mr = mr
  end

  def items
    mr.fetch_merchant_id(id)
  end

  def invoices
    mr.fetch_invoices(id)
  end

  def customers
    mr.fetch_customers_from_merchant_id(id)
  end
end
