require './test/test_helper.rb'
require './lib/transaction_repository.rb'
require './lib/file_loader.rb'

class TransactionRepositoryTest < Minitest::Test
  include FileLoader

  def test_it_exists
    tr = TransactionRepository.new(load_file("./data/transactions_test.csv"))
    assert_instance_of TransactionRepository, tr
  end

  def test_all_will_return_entire_repository
    tr = TransactionRepository.new(load_file("./data/transactions_test.csv"))
    assert_equal tr.repository, tr.all
  end

  def test_it_can_find_by_id_number
    tr = TransactionRepository.new(load_file("./data/transactions_test.csv"))
    assert_equal tr.all[0], tr.find_by_id(1)
    assert_equal nil, tr.find_by_id(5000)
  end

  def test_it_can_find_all_by_invoice_id
    tr = TransactionRepository.new(load_file("./data/transactions_test.csv"))
    assert_equal 1, tr.find_all_by_invoice_id(46).count
    assert_equal [], tr.find_all_by_invoice_id('oops')
  end

  def test_it_can_find_all_by_credit_card_number
    tr = TransactionRepository.new(load_file("./data/transactions_test.csv"))
    assert_equal 1, tr.find_all_by_credit_card_number("4271805778010747").count
    assert_equal [], tr.find_all_by_credit_card_number('not a number')
  end

  def test_it_can_find_all_by_result
    tr = TransactionRepository.new(load_file("./data/transactions_test.csv"))
    assert_equal 8, tr.find_all_by_result(:success).count
    assert_equal [], tr.find_all_by_result("oops")
  end

  def test_it_can_create_a_new_entry
    tr = TransactionRepository.new(load_file("./data/transactions_test.csv"))
    attributes = {
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    }
    new_transaction = tr.create(attributes)
    sorted = tr.repository.sort_by { |transaction| transaction.id }
    assert tr.repository.include?(new_transaction)
    assert_equal new_transaction, tr.find_by_id(10)
  end

  def test_it_can_update_an_entry
    tr = TransactionRepository.new(load_file("./data/transactions_test.csv"))
    attributes = {
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    }
    new_transaction = tr.create(attributes)
    original_time = tr.find_by_id(10).updated_at
    new_attributes = {
      :credit_card_number => '1234123412341234',
      :credit_card_expiration_date => '1220',
      :result => "failure"
    }
    id = 10
    tr.update(id, new_attributes)
    assert_equal'1234123412341234', tr.find_by_id(10).credit_card_number
    assert_equal '1220', tr.find_by_id(10).credit_card_expiration_date
    assert_equal 'failure', tr.find_by_id(10).result
    assert tr.find_by_id(10).updated_at > original_time
  end

  def test_it_can_delete_an_entry
    tr = TransactionRepository.new(load_file("./data/transactions_test.csv"))
    attributes = {
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    }
    new_transaction = tr.create(attributes)
    assert_equal 10, new_transaction.id
    tr.delete(10)
    assert_equal nil, tr.find_by_id(10)
  end

end
