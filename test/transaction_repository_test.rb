require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  attr_reader :t1, :t2, :repository

  def setup
    @t1 = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.new.to_s,
      :updated_at => Time.new.to_s
    })

    @t2 = Transaction.new({
      :id => 9,
      :invoice_id => 12,
      :credit_card_number => "4343434343434343",
      :credit_card_expiration_date => "0520",
      :result => "failure",
      :created_at => Time.new.to_s,
      :updated_at => Time.new.to_s
    })

    @repository = TransactionRepository.new
    @repository.transaction_repository = ([t1, t2])
  end

  def test_it_creates_a_new_instance_of_invoice_item_repo
    assert_equal TransactionRepository, repository.class
  end

  def test_it_returns_an_array_of_all_invoice_instances
    assert_equal 2, repository.all.length
  end

  def test_it_can_return_a_transaction_by_id
    transaction = repository.find_by_id(9)
    assert_equal "failure", transaction.result
  end

  def test_it_will_return_nil_if_invoice_item_does_not_exist
    assert_equal nil, repository.find_by_id(124)
  end

  def test_it_can_return_an_array_of_transaction_by_invoice_id
    transaction = repository.find_all_by_invoice_id(12)
    assert_equal "failure",transaction[0].result
  end

  def test_it_will_return_an_empty_array_if_item_id_doesnt_exist
    assert_equal [], repository.find_all_by_invoice_id(124)
  end

  def test_it_can_return_an_array_of_credit_card_numbers
    t = repository.find_all_by_credit_card_number("4242424242424242")
    assert_equal "success",t[0].result
  end

  def test_it_will_return_an_empty_array_if_credit_card_doesnt_exist
    assert_equal [], repository.find_all_by_credit_card_number(124)
  end

  def test_it_can_find_by_result
    t = repository.find_all_by_result("failure")
    assert_equal 1, t.length
  end

  def test_it_returns_empty_array_if_result_doesnt_exist
    t = repository.find_all_by_result("woo")
    assert t.empty?
  end

end
