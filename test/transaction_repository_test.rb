require './test/test_helper'
require './lib/transaction_repository'
require './lib/transaction'
require 'csv'

class TransactionRepositoryTest < Minitest::Test

  def setup
    @transactions = CSV.open './data/transaction_test_data.csv',
                              headers: true,
                              header_converters: :symbol
    @transaction_repository = TransactionRepository.new                              
  end

  def test_exists
    assert_instance_of TransactionRepository, @transaction_repository
  end

  def test_all_defaults_to_empty
    assert_equal [], @transaction_repository.all
  end

  def test_loads_csv
    @transaction_repository.load_transactions(@transactions)
    assert_equal 10, @transaction_repository.all.length
  end

  def test_find_by_id
    @transaction_repository.load_transactions(@transactions)
    actual = @transaction_repository.find_by_id(1)

    assert_equal "0217", actual.credit_card_expiration_date
  end
  
  def test_find_all_by_invoice_id
    @transaction_repository.load_transactions(@transactions)
    assert_equal [], @transaction_repository.find_all_by_invoice_id(217938)
    assert_equal 3, @transaction_repository.find_all_by_invoice_id(2179).length
  end

  def test_find_all_by_credit_card_number
    @transaction_repository.load_transactions(@transactions)

    assert_equal [], @transaction_repository.find_all_by_credit_card_number(123)
    assert_equal 3, @transaction_repository.find_all_by_credit_card_number("4068631943231473").length
  end

  def test_find_all_by_result
    @transaction_repository.load_transactions(@transactions)

    assert_equal [], @transaction_repository.find_all_by_result("fake status")
    assert_equal 9, @transaction_repository.find_all_by_result(:success).length
  end

  def test_create
    @transaction_repository.load_transactions(@transactions)
    attributes = {
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    }

    @transaction_repository.create(attributes)

    assert_equal 11, @transaction_repository.all.length
    assert_instance_of Transaction, @transaction_repository.all[-1]
    assert_equal 11, @transaction_repository.all[-1].id
  end

  def test_update
    @transaction_repository.load_transactions(@transactions)
    attributes = {
      :credit_card_number => "123",
      :credit_card_expiration_date => "1220",
      :result => :failed
    }
    time_before = @transaction_repository.all[-1].updated_at
    @transaction_repository.update(10, attributes)
    time_after = @transaction_repository.all[-1].updated_at
    
    assert time_before < time_after
    assert_equal "123", @transaction_repository.all[-1].credit_card_number
    assert_equal "1220", @transaction_repository.all[-1].credit_card_expiration_date
    assert_equal :failed, @transaction_repository.all[-1].result
  end

  def test_delete
    @transaction_repository.load_transactions(@transactions)

    @transaction_repository.delete(4)

    assert_equal 9, @transaction_repository.all.length
  end
end



























