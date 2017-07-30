class Merchant
  attr_reader :id,
              :name
  def initialize(data, mr = nil)
    @mr = mr
    @id = data[:id]
    @name = data[:name]
  end

  def items
    @mr.fetch_items(id)
  end

  def invoices
    @mr.fetch_invoices(id)
  end

  def customers
    @mr.fetch_customers_by_merchant_id(id)
  end

end
