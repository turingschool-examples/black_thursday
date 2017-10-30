class SalesEngine
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def self.from_csv(files)
    items = files[:items]
    SalesEngine.new(items)
  end

end
