class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(data)
    @items = data[:item]
    @merchants = data[:merchants]
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end
end
