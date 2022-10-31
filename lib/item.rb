class Item
  def initialize(stats)
    @stats = stats
  end

  def id
    @stats[:id]
  end

  def name
    @stats[:name]
  end
  
  def description
    @stats[:description]
  end

  def description
    @stats[:description]
  end

  def unit_price
    @stats[:unit_price]
  end

  def created_at
    @stats[:created_at]
  end
end