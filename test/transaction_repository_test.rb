# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/emoji'

require './lib/transaction_repository'
require './lib/transaction'

# Transaction Repository class tests
class TransactionRepositoryTest < Minitest::Test
  def setup
    @transrepo = TransactionRepository.new
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @transrepo
  end
end
