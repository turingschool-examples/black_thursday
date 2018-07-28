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
      result:                      'success',
      created_at:                  Time.now,
      updated_at:                  Time.now
    }
    @transaction2 = {
      id:                          9,
      invoice_id:                  10,
      credit_card_number:          '4222929305032939',
      credit_card_expiration_date: '0120',
      result:                      'failed',
      created_at:                  Time.now,
      updated_at:                  Time.now
    }
    @transaction3 = {
      id:                          14,
      invoice_id:                  11,
      credit_card_number:          '1616161616161616',
      credit_card_expiration_date: '0619',
      result:                      'success',
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
    @transrepo.create(@transaction1)
    @transrepo.create(@transaction2)
    @transrepo.create(@transaction3)

    refute_empty @transrepo.all
    assert_instance_of Array, @transrepo.all
  end
end
