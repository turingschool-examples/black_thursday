require_relative 'test_helper'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items => "./fixtures/items_small_list.csv",
      :invoices => "./fixtures/invoices_small_list.csv",
      :merchants => "./fixtures/merchant_small_list.csv",
      :invoice_items => "./fixtures/invoice_item_small_list.csv",
      :transactions => "./fixtures/transactions_small_list.csv",
      :customers => "./fixtures/customers_small_list.csv"
    })
  end

  def test_it_can_hold_customer_items
    result = @se.customers.find_by_id(6)

    assert_equal Customer, result.class
  end

  def test_it_can_find_by_first_name
    result = @se.customers.find_all_by_first_name("b")
    
    assert_equal Customer, result[0].class
    assert_equal Array, result.class
  end

  def test_it_can_find_by_last_name
    result = @se.customers.find_all_by_last_name("A")

    assert_equal Customer, result[0].class
    assert_equal Array, result.class
  end

end