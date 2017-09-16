require_relative 'test_helper'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < MiniTest::Test

  def setup
    se = SalesEngine.from_csv({
    :items     => "./test/fixtures/items_fixture.csv",
    :merchants => "./test/fixtures/merchants_fixture.csv",
    :invoices => "./test/fixtures/invoices_fixture.csv"
    })
    se.merchants
    se.items
    SalesAnalyst.new(se)
  end

  def test_it_exists
    sa = setup

    assert_instance_of SalesAnalyst, sa
  end

  def test_it_can_find_average_items_per_merchant
    sa = setup

    assert_equal 2.86, sa.average_items_per_merchant
  end

  def test_it_can_find_the_invoices_on_each_day
    sa = setup

    assert_instance_of Hash, sa.number_of_invoices_by_day
    assert_equal 7, sa.number_of_invoices_by_day.count
    assert_equal sa.number_of_invoices_by_day, {"Monday"=>5, "Tuesday"=>2, "Wednesday"=>11, "Thursday"=>9, "Friday"=>7, "Saturday"=>8, "Sunday"=>3}
  end

end
