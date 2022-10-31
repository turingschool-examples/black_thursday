class Item
  def initialize(stats)
    @stats = stats
  end

  def id
    @stats[:id]
  end
end