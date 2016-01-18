require_relative '../lib/transaction_repository'
require_relative 'spec_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'


class TransactionRepositoryTest < Minitest::Test
  attr_reader :repo


  def test_class_exist
    assert TransactionRepository
  end



end
