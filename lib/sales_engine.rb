require 'csv'

class SalesEngine

  def initialize(data = {})
    @items = data[:items],
    @merchants = data[:merchants]
  end

end

se = SalesEngine.new
a = se.csv_reader('./data/items.csv')
