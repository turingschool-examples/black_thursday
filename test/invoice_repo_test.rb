require 'CSV'
require './test/test_helper'

class InvoiceRepoTest < Minitest::Test

  def setup
    @engine = mock
    @dummy_repo = InvoiceRepo.new("./dummy_data/dummy_invoice.csv", @engine)
  end

  def test_it_is
    assert_instance_of InvoiceRepo, @dummy_repo
  end

  def test_it_has_attributes
    assert_instance_of Hash , @dummy_repo.collections
  end

  def test_it_can_find_merchant_id
    actual = @dummy_repo.find_all_by_merchant_id("12335938").flatten
    assert_equal "12335938", actual[0].merchant_id
  end

  def test_it_can_find_by_customer_id
    actual = @dummy_repo.find_all_by_customer_id("1").flatten
    assert_equal "1", actual[0].customer_id
  end

  def test_find_all_by_status
    actual = @dummy_repo.find_all_by_status("pending")
    assert_equal 9, actual.length
    assert_equal "pending", actual[0].status
  end

end
