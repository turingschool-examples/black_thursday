require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/sales_engine'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    files = ({:invoices => "./test/fixture/invoice_fixture.csv",
      :items => "./test/fixture/item_fixture.csv",
      :merchants => "./test/fixture/merchant_fixture.csv",
      :invoice_items => "./test/fixture/invoice_item_fixture.csv",
      :transactions => "./test/fixture/transaction_fixture.csv",
      :customers => "./test/fixture/customer_fixture.csv"})
    SalesEngine.from_csv(files).invoice_items
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, setup
  end

  def test_repo_pulls_in_CSV_info_from_invitems
    assert_equal 28, setup.all.count
  end

  def test_it_returns_array_of_all_invoice_items
    assert_equal 28, setup.all.count
  end

  def test_it_can_find_by_id

    assert_instance_of InvoiceItem, setup.find_by_id(1)
    assert_equal 5, setup.find_by_id(5).id
  end

  def test_it_can_find_all_by_item_id
    instances = setup.find_all_by_item_id(263451719)

    assert_equal 263451719, instances[0].item_id
    assert_equal 1, instances.count
  end

  def test_it_can_find_all_by_invoice_id
    instances = setup.find_all_by_invoice_id(3)

    assert_equal 3, instances[3].invoice_id
    assert_equal 8, instances.count
  end
end
