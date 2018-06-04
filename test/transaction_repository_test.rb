# frozen_string_literal: false

require_relative 'test_helper'
require './lib/sales_engine'
require './lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(transactions: './data/transactions.csv')
    @tr = @se.transactions
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @tr
  end

  def test_it_returns_an_array_of_all_known_transaction_instances
    assert_equal 4985, @tr.all.size
  end

  def test_all_returns_objects_in_array_are_transaction_objects
    transactions = @tr.all
    assert transactions.all? do |transaction|
      transaction.class == Transaction
    end
  end

  def test_it_can_find_by_id_number
    assert_equal @tr.all[0], @tr.find_by_id(1)
  end

  def test_it_can_find_all_by_invoice_id
    assert_equal 2, @tr.find_all_by_invoice_id(5).size
    assert_equal [], @tr.find_all_by_invoice_id('notarealid')
  end

  def test_it_can_find_all_by_credit_card_number
    actual = @tr.find_all_by_credit_card_number('4297222478855497').size
    assert_equal 1, actual
    assert_equal [], @tr.find_all_by_credit_card_number('notarealid')
  end

  def test_it_can_create_and_update_a_credit_card_number
    @tr.create(invoice_id: 54_321,
               credit_card_number: '333333333333333',
               credit_card_expiration_date: '0518',
               result: 'pending',
               created_at: Time.now,
               updated_at: Time.now)
    actual = @tr.find_all_by_credit_card_number('333333333333333').size
    assert_equal 1, actual
    assert_equal [], @tr.find_all_by_credit_card_number('7777777777777777')

    @tr.update(4986, invoice_id: 54_321,
                     credit_card_number: '7777777777777777',
                     credit_card_expiration_date: '7777',
                     result: 'shipped',
                     created_at: Time.now,
                     updated_at: Time.now)
    assert_equal [], @tr.find_all_by_credit_card_number('333333333333333')
    assert_equal 1, @tr.find_all_by_credit_card_number('7777777777777777').size
    assert_equal 'shipped', @tr.find_all_by_invoice_id(54_321)[0].result
  end

  def test_it_can_delete_a_transaction
    assert @tr.find_by_id(2)
    @tr.delete(2)
    refute @tr.find_by_id(2)
  end
end
