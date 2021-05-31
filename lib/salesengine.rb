class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(data)
    @items     = data[:items]
    @merchants = data[:merchants]
  end
end
