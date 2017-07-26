class Merchant
  attr_reader :id,
              :name

  def initialize(data, sales_engine)
    @sales_engine = sales_engine
    @id = data[:id].to_i
    @name = data[:name]
  end

  def items
    items = @sales_engine.items.find_all_by_merchant_id(self.id)
    items
  end

end
