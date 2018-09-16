require_relative 'test_helper'
require_relative '../lib/transaction_repository.rb'

class TransactionRepositoryTest <  Minitest::Test

  def test_it_exists
    tr = TransactionRepository.new('./data/transactions_tiny.csv')
    assert_instance_of TransactionRepository, tr
  end

  def test_it_loads_items
    tr = TransactionRepository.new('./data/transactions_tiny.csv')
    actual = tr.collection.length
    expected = 50
    assert_equal expected, actual
  end

  def test_all
    tr = TransactionRepository.new('./data/transactions_tiny.csv')
    actual = tr.all.length
    expected = 50
    assert_equal expected, actual
  end

  def test_find_by_id
    tr = TransactionRepository.new('./data/transactions_tiny.csv')
    found = tr.find_by_id(2)
    actual = found.id
    expected = 2
    assert_equal expected, actual
  end

  def test_find_all_by_invoice_id
    tr = TransactionRepository.new('./data/transactions_tiny.csv')
    actual = tr.find_all_by_invoice_id(2179).length
    expected = 1
    assert_equal expected, actual
  end

  def test_delete
    tr = TransactionRepository.new('./data/transactions_tiny.csv')
    assert_equal 50, tr.collection.length
    tr.delete(2)
    actual = tr.collection.length
    expected = 49
    assert_equal expected, actual
  end

  def test_create
    tr = TransactionRepository.new('./data/transactions_tiny.csv')
    tr.create({:id => 0, :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0202",
      :result => "success", :created_at => Time.now,
      :updated_at => Time.now})
    actual = tr.collection.max_by {|element| element.id}.id
    expected = 51
    assert_equal expected, actual
  end

  def test_update
    tr = TransactionRepository.new('./data/transactions_tiny.csv')
    attributes = { :credit_card_number =>  "4343434343434343"}
    tr.update(20, attributes)
    updated_item = tr.find_by_id(20)
    assert_equal "4343434343434343", updated_item.credit_card_number
  end

end
