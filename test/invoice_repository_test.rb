require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    files = ({:invoices => "./test/fixture/invoice_fixture.csv",
      :items => "./test/fixture/item_fixture.csv",
      :merchants => "./test/fixture/merchant_fixture.csv",
      :invoice_items => "./test/fixture/invoice_item_fixture.csv",
      :transactions => "./test/fixture/transaction_fixture.csv",
      :customers => "./test/fixture/customer_fixture.csv"})
    SalesEngine.from_csv(files).invoices
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, setup
  end

  def test_it_returns_array_of_all_invoices
    assert_equal 58, setup.all.count
  end

  def test_it_can_find_by_id
    assert_instance_of Invoice, setup.find_by_id(1)
    assert_equal 5, setup.find_by_id(5).id
  end

  def test_it_can_find_all_by_merchant_id
    instances = setup.find_all_by_merchant_id(12336161)

    assert_equal 12336161, instances[0].merchant_id
    assert_equal 1, instances.count
  end

  def test_it_can_find_all_by_customer_id
    instances = setup.find_all_by_customer_id(7)

    assert_equal 7, instances[0].customer_id
    assert_equal 4, instances.count
  end

  def test_it_can_find_by_status
    instances = setup.find_all_by_status("pending")
    assert_equal "pending", instances[5].status

    instances = setup.find_all_by_status("shipped")
    assert_equal "shipped", instances[4].status
  end
end
