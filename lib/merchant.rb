class Merchant
  attr_reader :merchant_info

  def initialize(merchant_info)
    @merchant_info = merchant_info
  end

  def name
    merchant_info[:name]
  end

  def id
    merchant_info[:id]
  end

  def items
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    se.items.find_all_by_merchant_id(id)
  end

end
