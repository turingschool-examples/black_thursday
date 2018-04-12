# frozen_string_literal: true

require './test/test_helper'
require './lib/sales_analyst'
# tests sales analyst
class SalesAnalystTest < Minitest::Test
  def test_it_exists
    se = SalesAnalyst.new
    assert_instance_of SalesAnalyst, se
  end
end
