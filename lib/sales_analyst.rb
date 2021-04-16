class SalesAnalyst

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def find_all_merchants
    @engine.merchants.merchants
  end

  def find_all_items
    @engine.items.array_of_objects
    
  end

end
