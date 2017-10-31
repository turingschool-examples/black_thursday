class SalesEngine
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

class Merchant
  attr_reader :name,
              :id,
              :parent
              # :created_at,
              # :updated_at

  def initialize(info = {}, parent=nil)
    @name = info[:name]
    @id  = info[:id]
    @parent = parent
    # @created_at =info[:created_at]
    # @updated_at =info[:updated_at]
  end

  def sales_engine
    parent.name
  end

end

class Item
  attr_reader :name, :parent
  def initialize(name, parent=nil)
    @name = name
    @parent = parent
  end
end

sa = SalesEngine.new("luis")
merchant = Merchant.new({name: "mig", id: 1, }, sa)
item = Item.new("tool", merchant)
