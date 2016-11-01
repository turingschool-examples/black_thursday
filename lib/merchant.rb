class Merchant

  attr_reader :id,
              :name

  def initialize(data)
    @id = data[:id]
    @name = data[:name]
  end

  def items
    SalesEngine.items.find_all_by_merchant_id(id)
  end

end