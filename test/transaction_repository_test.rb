require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
attr_reader :tr

  def setup
    @tr = TransactionRepository.new('./test/fixtures/transaction_fixture.csv')
  end

  def test_pull_csv
    assert_instance_of CSV, tr.pull_csv
  end

  def test_all
    assert_equal [], tr.all
  end
end
