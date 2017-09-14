class Merchant

  attr_reader :id, :name, :engine

  def initialize(merchant_info, engine)
    @id = merchant_info[:id].to_i
    @name = merchant_info[:name]
    @engine = engine
  end

  def items
    #helper method in engine to access merchants directly
    @engine.items.find_all_by_merchant_id(@id)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end


end
