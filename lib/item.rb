class Item # < ItemRepo

  attr_reader :name, :parent

  def initialize(data, parent)
    @name = data[:name]
    @parent = parent
  end

  def merchant(merchant)
    @parent.merchant(merchant)
  end

end
