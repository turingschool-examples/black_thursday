# frozen_string_literal: true

require './test_helper'
require './lib/sales_analyst'
# tests sales analyst
class SalesAnalyst < Minitest::Test
  def test_it_exists
    se = SalesAnalyst.new
    assert_instance_of SalesAnalyst, se
  end
end
