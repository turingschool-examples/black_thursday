require_relative 'test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def setup
    @mr = MerchantRepository.new
  end

  def test_merchant_instance_can_be_created
    skip
    merchant_1 = mock('name_one')
    merchant_2 = mock('name_two')
    expected = ['name_one', 'name_two']
    submitted = @mr.all

    assert_equal expected, submitted
  end

  def test_it_can_load_the_merchant_csv_file
    expected = "../data/merchant.csv"
    submitted = @mr.load_data(expected)

    assert_equal expected, @mr.load_data
  end
end
