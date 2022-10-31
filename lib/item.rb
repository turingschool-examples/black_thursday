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
end