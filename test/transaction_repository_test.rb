require_relative 'test_helper'
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_engine'

class TransactionRepositoryTest < Minitest::Test
  def setup
    files = ({:invoices => "./test/fixture/invoice_fixture.csv",
      :items => "./test/fixture/item_fixture.csv",
      :merchants => "./test/fixture/merchant_fixture.csv",
      :invoice_items => "./test/fixture/invoice_item_fixture.csv",
      :transactions => "./test/fixture/transaction_fixture.csv",
      :customers => "./test/fixture/customer_fixture.csv"})
    SalesEngine.from_csv(files).transactions
  end

  def test_it_exists
    assert_instance_of TransactionRepository, setup
  end

  def test_it_returns_array_of_all_invoices
    assert_equal 19, setup.all.count
  end

  def test_it_can_find_by_id
    assert_instance_of Transaction, setup.find_by_id(1)
    assert_equal 5, setup.find_by_id(5).id
  end

  def test_it_can_find_all_by_invoice_id
    instances = setup.find_all_by_invoice_id(290)

    assert_equal 290, instances[0].invoice_id
    assert_equal 1, instances.count
  end

  def test_it_can_find_all_by_cc_number
    instances = setup.find_all_by_credit_card_number(4297222478855497)

    assert_equal 1, instances.count
  end

  def test_it_can_find_all_by_result
    instances = setup.find_all_by_result("success")

    assert_equal "success", instances[4].result
    assert_equal 16, instances.count
  end
end
