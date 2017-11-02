require 'test_helper'

class SalesAnalystTest < Minitest::Test

  def setup
    @sales_analyst = SalesAnalyst.new(items_file, merchants_file)
  end


  def test_that_we_find_average_items_per_merchant

  end


end
