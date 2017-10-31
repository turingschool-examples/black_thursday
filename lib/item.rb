class Item # < ItemRepo

  attr_reader :name, :parent, :merchant_id

  def initialize(data, parent)
    @name = data[:name]
    @merchant_id = data[:merchant_id]
    @parent = parent
  end

  def merchant
    parent.merchant(merchant_id)
  end

end
