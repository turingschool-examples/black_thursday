require './test/test_helper'

class TransactionRepositoryTest < Minitest::Test

  def setup
    item_path          = "./data/items.csv"
    merchant_path      = "./data/merchants.csv"
    invoice_path       = "./data/invoices.csv"
    invoice_item_path  = "./data/invoice_items.csv"
    customer_path      = "./data/customers.csv"
    transaction_path   = "./data/transactions.csv"
    arguments = {
                  :items     => item_path,
                  :merchants => merchant_path,
                  :invoices  => invoice_path,
                  :invoice_items => invoice_item_path,
                  :customers     => customer_path,
                  :transactions => transaction_path
                }
    @engine = SalesEngine.from_csv(arguments)
  end

  def test_all_returns_all_transactions
    expected = @engine.transactions.all
    assert_equal 4985, expected.count
  end

  def test_find_by_id_returns_a_transaction_matching_the_given_id
    id = 2
    expected = @engine.transactions.find_by_id(id)

    assert_equal id, expected.id
    assert_instance_of Transaction, expected
  end

  def find_all_by_invoice_id_returns_all_transactions_matching_the_given_id
    id = 2179
    expected = @engine.transactions.find_all_by_invoice_id(id)

    assert_equal 2, expected.length
    assert_equal id, expected.id
    assert_instance_of Transaction, expected.first

    id = 14560
    expected = engine.transactions.find_all_by_invoice_id(id)

    assert_equal true, expected.empty?
  end

  def test_find_all_by_credit_card_number_returns_all_transactions_matching_given_credit_card_number

    credit_card_number = "4848466917766329"
    expected = @engine.transactions.find_all_by_credit_card_number(credit_card_number)

    assert_equal 1, expected.length
    assert_instance_of Transaction, expected.first
    assert_equal credit_card_number, expected.first.credit_card_number
  end

  def test_find_all_by_result_returns_all_transactions_matching_given_result
    result = :success
    expected = @engine.transactions.find_all_by_result(result)

    assert_equal 4158, expected.length
    assert_instance_of Transaction, expected.first
    assert_equal result, expected.first.result

    result = :failed
    expected = @engine.transactions.find_all_by_result(result)

    assert_equal 827, expected.length
    assert_instance_of Transaction, expected.first
    assert_equal result, expected.first.result
  end

  def test_create_creates_a_new_transaction_instance
    attributes = {
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    }
    @engine.transactions.create(attributes)
    expected = @engine.transactions.find_by_id(4986)

    assert_equal 8, expected.invoice_id
  end

  def test_update_updates_a_transaction
    attributes = {
                  :invoice_id => 8,
                  :credit_card_number => "4242424242424242",
                  :credit_card_expiration_date => "0220",
                  :result => "success",
                  :created_at => Time.now,
                  :updated_at => Time.now
                  }
    @engine.transactions.create(attributes)
    original_time = @engine.transactions.find_by_id(4986).updated_at
    attributes = {result: :failed}
    @engine.transactions.update(4986, attributes)
    expected = @engine.transactions.find_by_id(5000)

    assert_nil expected

    expected = @engine.transactions.find_by_id(4986)

    refute attributes[:invoice_id], expected.invoice_id
    refute attributes[:created_at], expected.created_at
  end

  def test_update_cannot_update_id_invoice_id_or_created_at
    attributes_1 = {
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    }
    @engine.transactions.create(attributes_1)
    attributes = {
                  id: 5000,
                  invoice_id: 2,
                  created_at: Time.now
                  }
    @engine.transactions.update(4986, attributes)
    expected = @engine.transactions.find_by_id(5000)
    #assert that transaction 5000 doesn not exist
    assert_nil expected

    expected = @engine.transactions.find_by_id(4986)

    assert_equal attributes_1[:invoice_id], expected.invoice_id
    assert_operator attributes_1[:created_at].to_s, :==,  expected.created_at.to_s
  end

  def test_delete_deletes_the_specified_transaction
    @engine.transactions.delete(4986)
    expected = @engine.transactions.find_by_id(4986)

    assert_nil expected
  end
end
