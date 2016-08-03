require "./test/test_helper"
require "./lib/merchant"

class MerchantsRepoTest < Minitest::Test

  def test_it_can_find_the_id
    merch = Merchant.new({id: "12334347"})
    assert_equal 12334347, merch.id
  end

  def test_it_can_find_the_name
    merch = Merchant.new({name: "EkaterinaPa"})
    assert_equal "EkaterinaPa", merch.name
  end

  def test_it_can_find_the_date_created
    merch = Merchant.new({created_at: "2006-08-07"})
    time = Time.strptime("2006-08-07", "%Y-%m-%d")
    assert_equal time, merch.created_at
  end

  def test_it_can_find_the_date_updated
    merch = Merchant.new({updated_at: "2015-10-11"})
    time = Time.strptime("2015-10-11", "%Y-%m-%d")
    assert_equal time, merch.updated_at
  end

  def test_it_has_items
    mock_mr = Minitest::Mock.new
    mock_mr.expect(:find_all_items_by_merchant_id, ["item1", "item2"], [12334347])
    merch = Merchant.new({:id => "12334347"}, mock_mr)
    assert_equal 2, merch.items.count
    assert mock_mr.verify
  end

  def test_it_has_invoices
    mock_mr = Minitest::Mock.new
    mock_mr.expect(:find_all_invoices_by_merchant_id, ["invoice"],[12334347])
    merch = Merchant.new({id: "12334347"}, mock_mr)
    assert_equal 1, merch.invoices.count
    assert mock_mr.verify
  end

  def test_it_has_customers
    mock_mr = Minitest::Mock.new
    mock_mr.expect(:find_all_customers_by_merchant_id, ["customer"], [12334347])
    merch = Merchant.new({id: "12334347"}, mock_mr)
    assert_equal 1, merch.customers.count
    assert mock_mr.verify
  end
end
