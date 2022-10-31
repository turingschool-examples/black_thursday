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

  def updated_at
    @stats[:updated_at]
  end
end