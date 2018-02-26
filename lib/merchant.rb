class Merchant
  attr_reader :id, :name, :created_at
  def initialize(data, parent)
    @id = data[:id].to_i
    @name = data[:name]
    @created_at = Time.parse(data[:created_at])
    @parent = parent
  end

  def items
    @parent.merch_repo_goes_to_sales_engine_with_merchant_id(@id)
  end

  def invoices
    @parent.merch_repo_finds_invoices_via_engine(@id)
  end

  def customers
    @parent.merch_repo_finds_customers_via_engine(@id)
  end
end
