class Merchant
  attr_reader :id, :name, :parent
  
  def initialize(data, parent=nil)
    @id  = data[:id]
    @name = data[:name]
    @parent = parent
  end

  def items
    parent.parent.items.find_all_by_merchant_id(@id)
  end

end


# m = Merchant.new({:id => 5, :name => "Turing School"})