require_relative '../lib/transaction'
require_relative 'spec_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'


class TransactionTest < Minitest::Test

  def test_that_class_exist
    assert Transaction
  end

end
