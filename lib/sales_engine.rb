class SalesEngine
  def initialize(sales_data)
    @items = sales_data[:items]
    @merchants = sales_data[:merchants]
  end
end
