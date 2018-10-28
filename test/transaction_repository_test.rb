require 'minitest/autorun'
require 'minitest/pride'
require './lib/transaction_repository'
require './lib/transaction'

class TransactionRepositoryTest < Minitest::Test

  def test_it_exists
    tr = TransactionRepository.new("./data/transactions.csv")

    assert_instance_of TransactionRepository, tr
  end

  def test_it_has_invoices
    tr = TransactionRepository.new("./data/transactions.csv")

    assert_instance_of Transaction, tr.all[0]
    assert_equal 4985,tr.all.count
  end

  def test_it_can_find_by_id
    tr = TransactionRepository.new("./data/transactions.csv")

    assert_equal tr.all[1], tr.find_by_id(2)
  end

  def test_it_can_find_all_by_id
    tr = TransactionRepository.new("./data/transactions.csv")

    assert_equal [tr.all[0], tr.all[766]], tr.find_all_by_invoice_id(2179)
    assert_equal [], tr.find_all_by_invoice_id("aaa")
  end

  def test_it_can_find_all_by_credit_card_number
    tr = TransactionRepository.new("./data/transactions.csv")

    assert_equal [tr.all[0]], tr.find_all_by_credit_card_number("4068631943231473")
    assert_equal [], tr.find_all_by_credit_card_number("aa")
  end

  def test_you_can_find_all_by_result
    tr = TransactionRepository.new("./data/transactions.csv")

    assert_equal 4158, tr.find_all_by_result("success").count
    assert_equal [], tr.find_all_by_result("adsf")
  end

  def test_you_can_create_a_new_transaction
    tr = TransactionRepository.new("./data/transactions.csv")
    data = {
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now.to_s,
      :updated_at => Time.now.to_s
      }
      actual = tr.create(data).last
      expected = tr.find_by_id(4986)
    assert_equal expected, actual
  end

  def test_it_can_update_one_attribute_of_an_existing_item
    tr = TransactionRepository.new("./data/transactions.csv")
    tr.update(6, {credit_card_number: "11111111111111",
      credit_card_expiration_date: "8080"})
    updated_transaction = tr.all[6]
    assert_equal "1111111111111111" , updated_transaction.credit_card_number
    assert_equal "8080" , updated_transaction.credit_card_expiration_date
  end
end
