require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/transaction_repo'

class TransactionRepoTest < Minitest::Test
  def test_it_exist
    tr = TransactionRepo.new("./test/fixtures/transactions.csv")
    assert_instance_of TransactionRepo, tr
  end

  def test_it_returns_all_items_in_an_array
    tr = TransactionRepo.new("./test/fixtures/transactions.csv")

    assert_equal "0217", tr.all.first.credit_card_expiration_date
    assert_instance_of Array, tr.all
    assert_equal 11, tr.all.count
    assert_equal "success", tr.all.first.result
  end

  def test_it_can_find_an_item_by_id
    tr = TransactionRepo.new("./test/fixtures/transactions.csv")

    actual = tr.find_by_id(2)
    assert_instance_of Transaction, actual
    assert_equal "success", actual.result
    assert_equal 2, actual.id
  end

  def test_it_returns_nil_if_no_id_match_found
    tr = TransactionRepo.new("./test/fixtures/transactions.csv")

    actual = tr.find_by_id(28349289034)
    assert_nil actual
  end

  def test_it_can_find_all_invoice_by_id
    tr = TransactionRepo.new("./test/fixtures/transactions.csv")

    t_one = tr.find_by_id(4)
    t_two = tr.find_by_id(5)

    expected = [t_one, t_two]
    actual = tr.find_all_by_invoice_id(4115)
    assert_equal expected, actual

    assert_equal [], tr.find_all_by_invoice_id(99999)
  end

  def test_it_can_find_all_by_credit_card_number
    tr = TransactionRepo.new("./test/fixtures/transactions.csv")

    t_one = tr.find_by_id(4)
    t_two = tr.find_by_id(5)

    expected = [t_one, t_two]
    actual = tr.find_all_by_credit_card_number("4048033451067370")
    assert_equal expected, actual

    assert_equal [], tr.find_all_by_credit_card_number(99999)
  end

  def test_it_can_find_all_by_result
    tr = TransactionRepo.new("./test/fixtures/transactions.csv")

    expected = tr.find_by_id(9)
    assert_equal [expected], tr.find_all_by_result("failed")

    actual = tr.find_all_by_result("success")
    assert_equal 10, actual.count

    assert_equal [], tr.find_all_by_result("asdfdf")
  end

  def test_it_can_create_a_transaction_with_current_highest_id
    tr = TransactionRepo.new("./test/fixtures/transactions.csv")

    actual = tr.create({
      :id                            => 15,
      :invoice_id                    => 232321,
      :credit_card_number            => "4463525332822968",
      :credit_card_expiration_date   => "0422",
      :result                        => "failed",
      :created_at                    => Time.now,
      :updated_at                    => Time.now,
                        })

    assert_instance_of Transaction, actual

  assert_equal 12, tr.all.count
  end

  def test_it_can_update_a_transaction
    tr = TransactionRepo.new("./test/fixtures/transactions.csv")

    actual = tr.find_by_id(11)
    tr.update(11,{
      :credit_card_number            => "1163525332822968",
      :credit_card_expiration_date   => "0218",
      :result                        => "failed",
      :updated_at                    => Time.now,
                        })

    assert_instance_of Transaction, actual
    assert_equal "1163525332822968", actual.credit_card_number
    assert_equal "failed", actual.result
    assert_equal "0218", actual.credit_card_expiration_date
    assert_instance_of Time, actual.updated_at
  end

  def test_it_can_delete_by_id
    tr = TransactionRepo.new("./test/fixtures/transactions.csv")

    tr.delete(11)
    assert_nil tr.find_by_id(11)
  end
end
