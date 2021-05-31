class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(data)
    @items     = data[:items]
    @merchants = data[:merchants]
    require "pry"; binding.pry
  end
end
