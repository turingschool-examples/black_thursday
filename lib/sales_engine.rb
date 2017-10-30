class SalesEngine
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def self.from_csv(file)
    item = file[:item]
    SalesEngine.new(item)
  end

end
