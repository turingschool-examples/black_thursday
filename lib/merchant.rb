class Merchant
  attr_reader :id, :name
  def initialize(data, parent)
    @id = data[:id].to_i
    @name = data[:name]
    @parent = parent
  end

  def items
    @parent.merch_repo_goes_to_sales_engine_with_merchant_id(self.id)
           #.get_items_merch_to_repo(self.id)
  end

  def invoices
    @parent.merch_repo_finds_invoices_via_engine(self.id)
  end

  def customers
    @parent.merch_repo_finds_customers_via_engine(self.id)
  end
end
