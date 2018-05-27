class SalesEngine
  attr_reader :items,
              :merchants

  def initialize
    @items
    @merchants
  end

  def from_csv(sales_data)
    @items = CSV.read(sales_data[:items])
    @merchants = CSV.read(sales_data[:merchants])
  end

end
