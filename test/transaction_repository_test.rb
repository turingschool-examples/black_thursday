require_relative 'test_helper'

class TransactionRepositoryTest < Minitest::Test

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
  
  def test_it_populates_transaction_items
    result = @se.transactions.find_by_id(6)

    assert_equal Transaction, result.class
  end

  def test_it_can_find_by_invoice_id
    result = @se.transactions.find_all_by_invoice_id(46)

    assert_equal Transaction, result[0].class
    assert_equal Array, result.class
  end

  def test_it_can_find_by_credit_card_number
    result = @se.transactions.find_all_by_credit_card_number(4271805778010747)

    assert_equal Transaction, result[0].class
    assert_equal Array, result.class
  end

  def test_it_can_find_by_transaction_result
    result = @se.transactions.find_all_by_result("success")

    assert_equal Transaction, result[0].class
  end
end