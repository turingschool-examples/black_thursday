class Item # < ItemRepo

  attr_reader :data, :parent

  def initialize(data, parent)
    @data = data
    @parent = parent
  end

  def merchant(merchant)
    @parent.merchant(merchant)
  end

end
