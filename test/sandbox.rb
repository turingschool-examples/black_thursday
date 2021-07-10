require 'test_helper'

require 'pry'
require 'bigdecimal'
require 'csv'


class SalesEngine

  def initialize(csv_data)
    @items = csv_data[:items]
    @merchants = csv_data[:merchants]
  end

end

se = SalesEngine.from_csv({
	  :items     => "./data/items.csv",
	  :merchants => "./data/merchants.csv",
	})
