# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/emoji'

require './lib/transaction_repository'
require './lib/transaction'

# Transaction Repository class tests
class TransactionRepositoryTest < Minitest::Test
  def setup
    @transrepo = TransactionRepository.new
    @transaction1 = {
      id:                          6,
      invoice_id:                  8,
      credit_card_number:          '4242424242424242',
      credit_card_expiration_date: '0220',
      result:                      :success,
      created_at:                  Time.now,
      updated_at:                  Time.now
    }
    @transaction2 = {
      id:                          9,
      invoice_id:                  8,
      credit_card_number:          '4222929305032939',
      credit_card_expiration_date: '0120',
      result:                      :failed,
      created_at:                  Time.now,
      updated_at:                  Time.now
    }
    @transaction3 = {
      id:                          14,
      invoice_id:                  11,
      credit_card_number:          '4242424242424242',
      credit_card_expiration_date: '0619',
      result:                      :success,
      created_at:                  Time.now,
      updated_at:                  Time.now
    }
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @transrepo
  end

  def test_it_can_create_transactions
    actual = @transrepo.create(@transaction1)

    assert_instance_of Transaction, actual
  end

  def test_it_returns_all_transactions_in_an_array
    expected1 = @transrepo.create(@transaction1)
    expected2 = @transrepo.create(@transaction2)
    expected3 = @transrepo.create(@transaction3)
    expected_array = [expected1, expected2, expected3]

    assert_equal expected_array, @transrepo.all
    assert_instance_of Array, @transrepo.all
  end

  def test_it_finds_transactions_by_id
    expected = @transrepo.create(@transaction1)

    assert_equal expected, @transrepo.find_by_id(6)
  end

  def test_it_can_find_all_by_invoice_id
    expected1 = @transrepo.create(@transaction1)
    expected2 = @transrepo.create(@transaction2)
    @transrepo.create(@transaction3)

    expected_array = [expected1, expected2]

    assert_equal expected_array, @transrepo.find_all_by_invoice_id(8)
  end

  def test_it_can_find_all_by_cc_number
    expected1 = @transrepo.create(@transaction1)
    @transrepo.create(@transaction2)
    expected3 = @transrepo.create(@transaction3)

    expected_array = [expected1, expected3]
    actual = @transrepo.find_all_by_credit_card_number('4242424242424242')

    assert_equal expected_array, actual
  end

  def test_it_can_find_all_by_result
    expected1 = @transrepo.create(@transaction1)
    @transrepo.create(@transaction2)
    expected3 = @transrepo.create(@transaction3)

    expected_array = [expected1, expected3]
    actual = @transrepo.find_all_by_result(:success)

    assert_equal expected_array, actual
  end

  def test_it_can_delete_transactions
    @transrepo.create(@transaction1)
    expected2 = @transrepo.create(@transaction2)
    expected3 = @transrepo.create(@transaction3)

    expected = [expected2, expected3]

    @transrepo.delete(6)

    assert_equal expected, @transrepo.all
  end

  def test_it_can_update_transactions
    transaction = @transrepo.create(@transaction1)

    update_params = {
      credit_card_number:          '1020102010201020',
      credit_card_expiration_date: '0120',
      result:                      :failed
    }
    @transrepo.update(6, update_params)

    expected = ['1020102010201020', '0120', :failed]
    actual   = [transaction.credit_card_number, transaction.credit_card_expiration_date, transaction.result]

    assert_equal expected, actual
  end
end
