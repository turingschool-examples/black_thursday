require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/repository'
require_relative '../test/file_hash_setup'
require_relative '../lib/sales_engine'
require_relative '../lib/transaction_repository'
require_relative '../lib/transaction'


class TransactionRepositoryTest < Minitest::Test

  attr_reader :file_hash, :path, :se, :repo, :transaction_repository

  include FileHashSetup

  def setup
    super
    @path = 'test/fixtures/transaction_sample.csv'
    @repo = Repository.new(se, path, Transaction)
    @transaction_repository = TransactionRepository.new(se, path)
  end

  def test_it_finds_all_transactions
    assert_equal Array, transaction_repository.all.class
    refute_empty transaction_repository.all
  end

end
