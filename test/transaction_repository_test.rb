require_relative '../lib/transaction_repository'
require_relative '../lib/transaction'
require_relative '../lib/sales_engine'
require_relative './test_helper'
require 'pry'

class TransactoinRepositoryTest < Minitest::Test
  def test_it_exists
    tr = TransactoinRepository.new('./short_tests/short_transaction.csv')

    assert_instance_of TransactoinRepository, tr
  end

  def test_it_can_find_all_by_invoice_id
    tr = TransactoinRepository.new('./short_tests/short_transaction.csv')

    transaction = tr.find_by_id(1)

    assert_equal [], tr.find_all_by_invoice_id(123456789)
    assert_equal [transaction], tr.find_all_by_invoice_id(2179)
  end

  def test_it_can_find_all_by_credit_card_number
    tr = TransactoinRepository.new('./short_tests/short_transaction.csv')

    transaction = tr.find_by_id(2)

    assert_equal [], tr.find_all_by_credit_card_number("123456789")
    assert_equal [transaction], tr.find_all_by_credit_card_number("4177816490204479")
  end

  def test_it_can_find_all_by_result
    tr = TransactoinRepository.new('./short_tests/short_transaction.csv')

    transaction = tr.find_by_id(9)

    assert_equal [transaction], tr.find_all_by_result("failed")
  end

  def test_it_create_attributes
    tr = TransactoinRepository.new('./short_tests/short_transaction.csv')

    attributes = ({
    :id => 6,
    :invoice_id => 8,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
    })

    tr.create(attributes)
    assert_equal 11, tr.repo.last.id
  end

  def test_it_can_update_attributes
    tr = TransactoinRepository.new('./short_tests/short_transaction.csv')

    credit_1 = tr.find_by_id(10)
    tr.update(10, {credit_card_number: "3456343456"})

    assert_equal "3456343456", credit_1.credit_card_number
  end

end
