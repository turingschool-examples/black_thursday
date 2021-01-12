require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/invoice_repo'
require './lib/invoice'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchant_repo'
require './lib/item'
require './lib/item_repo'
require './lib/transaction'
require './lib/transaction_repo'

class TransactionRepoTest < MiniTest::Test

  def setup
    @se = SalesEngine.from_csv({
                              :transactions => "./data/transactions.csv"
                              })
    @transaction = @se.transactions
  end

  def test_it_exists
    assert_instance_of TransactionRepo, @transaction
  end

  def test_transaction_repo_can_find_all
    expected = @se.transactions.all
    assert_equal 4985, expected.count
  end

  def test_transaction_repo_can_find_by_id
    expected = @transaction.find_by_id(2)
    expect_nil = @transaction.find_by_id(000)

    assert_equal 2, expected.id
    assert_equal Transaction, expected.class
    assert_nil expect_nil
  end

  def test_find_all_by_invoice_id
    expected = @se.transactions.find_all_by_invoice_id(2179)

    assert_equal 2, expected.length
    assert_equal 2179, expected.first.invoice_id
    assert_equal Transaction, expected.first.class
  end

  def test_find_all_by_credit_card_number
  expected = @transaction.find_all_by_credit_card_number("4848466917766329")

  assert_equal 1, expected.length
  assert_equal Transaction, expected.first.class
  end

  def test_find_find_all_by_result
  expected = @transaction.find_all_by_result(:success)

  assert_equal 4158, expected.length
  assert_equal Transaction, expected.first.class
  end

  def test_create_attributes
  attributes = {
                :invoice_id => 8,
                :credit_card_number => "4242424242424242",
                :credit_card_expiration_date => "0220",
                :result => "success",
                :created_at => Time.now,
                :updated_at => Time.now
              }
  @se.transactions.create(attributes)
  expected = @transaction.find_by_id(4986)
  assert_equal 8, expected.invoice_id
  end

  def test_update_a_transaction
  transaction = @se.transactions.find_by_id(4158)
  original_time = transaction.updated_at
  attributes = {
                result: :failed
                }
  @transaction.update(4158, attributes)
  expected = @transaction.find_by_id(4158)
  assert_equal :failed, expected.result
  end

  def test_delete_a_tansaction
  @transaction.delete(4986)
  expected = @transaction.find_by_id(4986)
  assert_nil expected
  end
end
