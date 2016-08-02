require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repo'
require "pry"

class MerchantRepoTest < Minitest::Test
  def test_can_add_and_access_merchants
    mr = MerchantRepo.new
    mr.add({:name => "String store", :id => 24})
    assert_equal 1, mr.all.count
    assert_equal "String store", mr.all.first.name
  end

  def test_find_by_id
    mr = MerchantRepo.new
    mr.add({:name => "String store", :id => 24})
    mr.add({:name => "Fail store", :id => 25})
    found_merchant = mr.find_by_id(24)
    assert_equal 24, found_merchant.id
    assert_equal "String store", found_merchant.name
  end

  def test_fail_at_find_by_id
    mr = MerchantRepo.new
    mr.add({:name => "String store", :id => 24})
    assert_equal nil, mr.find_by_id(20)
  end

  def test_find_by_name
    mr = MerchantRepo.new
    mr.add({:name => "String store", :id => 24})
    mr.add({:name => "Trump store of Fail", :id => 666})
    found_merchant = mr.find_by_name("trump store of fail")
    assert_equal "Trump store of Fail", found_merchant.name
    assert_equal 666, found_merchant.id
  end

  def test_fail_at_find_by_name
    mr = MerchantRepo.new
    mr.add({:name => "String store", :id => 24})
    mr.add({:name => "Trump store of Fail", :id => 666})
    assert_equal nil, mr.find_by_name("Joe")
  end

  def test_find_all_by_name
    mr = MerchantRepo.new
    mr.add({:name => "String store", :id => 24})
    mr.add({:name => "Trump store of Fail", :id => 666})
    mr.add({:name => "Trump bank of Fail", :id => 667})
    found_merchants = mr.find_all_by_name("trump")
    assert_equal 2, found_merchants.count
    assert_equal 666, found_merchants.first.id
    assert_equal 667, found_merchants.last.id
  end

  def test_fail_at_find_all_by_name
    mr = MerchantRepo.new
    mr.add({:name => "String store", :id => 24})
    mr.add({:name => "Trump store of Fail", :id => 666})
    mr.add({:name => "Trump bank of Fail", :id => 667})
    assert_equal [], mr.find_all_by_name("Joe")
  end

  def test_merchant_has_repo
    merchant_details = {:name => "String store", :id => 24}
    mr = MerchantRepo.new
    mr.add(merchant_details)
    merchant = mr.all.first
    assert_equal mr, merchant.parent
  end

  def test_it_can_ask_engine_for_invoices
    mock_se = Minitest::Mock.new
    mr = MerchantRepo.new(mock_se)
    mock_se.expect(:find_invoices_by_merchant_id, [], [5])
    assert_equal [], mr.find_invoices_by_merchant_id(5)
    assert mock_se.verify
  end

  def test_passing_methods_to_sales_engine
    mock_se = Minitest::Mock.new
    mr = MerchantRepo.new(mock_se)
    mock_se.expect(:find_invoices_by_merchant_id, ["invoice"], [12334141] )
    assert_equal ["invoice"], mr.find_invoices_by_merchant_id(12334141)
    mock_se.expect(:find_customer_by_customer_id, "customer", [8] )
    assert_equal "customer", mr.find_customer_by_customer_id(8)
    assert mock_se.verify
  end
end
