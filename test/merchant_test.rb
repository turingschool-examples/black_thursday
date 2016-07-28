require "./test/test_helper"
require "./lib/merchant"
require "./lib/sales_engine"


class MerchantsRepoTest < Minitest::Test

  def test_it_can_find_the_id
    merch = {:created_at => "2006-08-07", :id => "12334347", :name => "EkaterinaPa", :updated_at =>"2015-10-11"}
    assert_equal 12334347, Merchant.new(merch).id
  end

  def test_it_can_find_the_name
    merch = {:created_at => "2006-08-07", :id => "12334347", :name => "EkaterinaPa", :updated_at =>"2015-10-11"}
    assert_equal "EkaterinaPa", Merchant.new(merch).name
  end

  def test_it_can_find_the_date_created
    merch = {:created_at => "2006-08-07", :id => "12334347", :name => "EkaterinaPa", :updated_at =>"2015-10-11"}
    time = Time.strptime("2006-08-07", "%Y-%m-%d")
    assert_equal time, Merchant.new(merch).created_at
  end

  def test_it_can_find_the_date_updated
    merch = {:created_at => "2006-08-07", :id => "12334347", :name => "EkaterinaPa", :updated_at =>"2015-10-11"}
    time = Time.strptime("2015-10-11", "%Y-%m-%d")
    assert_equal time, Merchant.new(merch).updated_at
  end

  def test_it_has_items
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/support/merchant_support.csv",
      })
    se.items
    merch = Merchant.new({:created_at => "2006-08-07", :id => "12334347", :name => "EkaterinaPa", :updated_at =>"2015-10-11"}, se.merchants)
    assert_equal 2, merch.items.count 
  end

end
