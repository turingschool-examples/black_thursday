require_relative './test_helper'
require 'time'
require './lib/transaction'
require './lib/transaction_repository'
require 'csv'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    @tr = TransactionRepository.new("./fixture_data/transactions_sample.csv", "engine")
  end

  def test_it_exists_and_has_attributes
    assert_instance_of TransactionRepository, @tr
    assert_equal 128, @tr.all.count
  end
end
