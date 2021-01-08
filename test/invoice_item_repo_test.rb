require 'CSV'
require './test/test_helper'

class InvoiceItemRepoTest < Minitest::Test

  def setup
    @engine = mock
    @dummy_repo = InvoiceItemRepo.new("./dummy_data/dummy_invoice_item.csv", @engine)
  end

  def test_it_is
    assert_instance_of InvoiceItemRepo, @dummy_repo
  end

  def test_it_has_attributes
    assert_instance_of Hash , @dummy_repo.collections
  end

  # def test_it_can_find_merchant_id
  #   actual = @dummy_repo.find_all_by_merchant_id("12335938").flatten
  #   assert_equal "12335938", actual[0].merchant_id
  # end
  #
  # def test_it_can_find_by_customer_id
  #   actual = @dummy_repo.find_all_by_customer_id("1").flatten
  #   assert_equal "1", actual[0].customer_id
  # end
  #
  # def test_find_all_by_status
  #   actual = @dummy_repo.find_all_by_status("pending")
  #   assert_equal 9, actual.length
  #   assert_equal "pending", actual[0].status
  # end
  #
  def test_it_can_create_new_item
    data ={
      :id => "910",
      :item_id => "11",
      :invoice_id => "6",
      :quantity => "4",
      :unit_price => "9999",
      :created_at => "2125-09-22 09:34:06 UTC",
      :updated_at => "2034-09-04 21:35:10 UTC"
      }
    @dummy_repo.create(data)
    actual = @dummy_repo.find_by_id("910")
    assert_equal "910", actual.id
  end
  #
  # def test_delete
  #   data ={
  #     :id => "910",
  #     :customer_id => "10",
  #     :merchant_id => "22335938",
  #     :status => "pending",
  #     :created_at => "2125-09-22 09:34:06 UTC",
  #     :updated_at => "2034-09-04 21:35:10 UTC"
  #     }
  #   @dummy_repo.create(data)
  #   @dummy_repo.delete("910")
  #
  #   assert_nil nil, @dummy_repo.find_all_by_merchant_id("22335938").flatten
  # end

end
