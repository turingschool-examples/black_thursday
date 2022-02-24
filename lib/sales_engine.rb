#sales_engine
class SalesEngine
  attr_reader :items, :merchants

  def initialize(hash)
    @items = hash[:items]
    @merchants = hash[:merchants]
  end
end
