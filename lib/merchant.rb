class Merchant
  attr_reader :id, :name
  def initialize(data, parent)
    @id = data[:id].to_i
    @name = data[:name]
    @parent = parent
  end

  def items
    @parent.merch_repo_goes_to_sales_engine_with_merchant_id(self.id)
  end
end
