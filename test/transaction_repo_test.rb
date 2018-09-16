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
    skip
    tr = TransactionRepository.new('./data/transactions_tiny.csv')
    tr.create({:id => 0, :name =>"Pencil", :description => "You can use it to write things", :unit_price => BigDecimal.new(10.99,4) , :created_at=> Time.now, :updated_at=> Time.now, :merchant_id => 2})
    actual = tr.collection.max_by {|element| element.id}.id
    expected = 263398180
    assert_equal expected, actual
  end

  def test_update
    skip
    tr = TransactionRepository.new('./data/transactions_tiny.csv')
    attributes = { unit_price: BigDecimal.new(379.99, 5) }
    tr.update(263397919, attributes)
    updated_item = tr.find_by_id(263397919)
    assert_equal 379.99, updated_item.unit_price
  end

end
