require_relative 'test_helper'
require './lib/transaction'
require './lib/transaction_repository'


class TransactionRepositoryTest < Minitest::Test

  def setup
    @trxr = TransactionRepository.new()
  end

  def test_transaction_reposirtory_class_exist
    assert_instance_of TransactionRepository, @trxr
  end

  def test_from_csv_populates_data
    @trxr.from_csv("./test/fixtures/transaction_truncated_10.csv")

    assert_equal 10, @trxr.all.count
  end

  def test_transaction_repository_begins_with_empty_array_called_by_the_all_method
    assert_equal [], @trxr.all
  end

  def test_trx_cvs_file_returns_correct_matching_id
    @trxr.from_csv("./test/fixtures/transaction_truncated_10.csv")

    assert_equal "4126", @trxr.all[3].invoice_id
  end

  def test_trx_cvs_file_returns_correct_matching_id
    @trxr.from_csv("./test/fixtures/transaction_truncated_10.csv")

    assert_equal "4126", @trxr.all[3].invoice_id
  end

  def method_name
    
  end

end
