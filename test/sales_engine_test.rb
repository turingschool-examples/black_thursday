require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.new()
  end

  def test_if_no_file_is_entered_return_nil
    submitted = @se.file
    assert_equal [], submitted
  end

  def test_if_one_file_is_entered_returns_file
    skip
    file = "./data/merchants.csv"
    @se = SalesEngine.new(file)
    submitted = @se.file

    assert_equal [file], submitted
  end

  # def test_if_two_files_are_entered_returns_files
  #   skip
  #   file_one = "./data/merchants.csv"
  #   file_two = "./data/items.csv"
  #   file_array = [file_one, file_two]
  #   @se = SalesEngine.new(file_one, file_two)
  #   submitted = @se.file
  #
  #   assert_equal file_array, submitted
  # end
  #
  # def test_if_three_files_are_entered_returns_files
  #   skip
  #   file_one = "./data/merchants.csv"
  #   file_two = "./data/items.csv"
  #   file_three = "./data/invoices.csv"
  #   file_array = [file_one, file_two, file_three]
  #   @se = SalesEngine.new(file_one, file_two, file_three)
  #   submitted = @se.file
  #
  #   assert_equal file_array, submitted
  # end
  #
  # def test_receive_command_one_file
  #   skip
  #   file = "./data/merchants.csv"
  #   command = "all"
  #   @se = SalesEngine.new(file)
  #   submitted = @se.command
  #
  #   assert_equal command, submitted
  # end
  #
  # def test_receive_command_two_files
  #   skip
  # end
end
