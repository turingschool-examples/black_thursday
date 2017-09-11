require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'


class MerchantRepositoryTest < Minitest::Test

  def test_it_exists

    mr = MerchantRepository.new('./data/merchants_fixture.csv')
    assert_instance_of MerchantRepository, mr
  end

  def test_it_can_parse_data
    mr = MerchantRepository.new('./data/merchants_fixture.csv')

    assert mr.merchants.length > 0
  end

  def test_it_has_the_correct_first_entry_id
    mr = MerchantRepository.new('./data/merchants_fixture.csv')

    assert_equal "12334105", mr.merchants[0].id
  end

  def test_it_has_the_correct_first_entry_name
    mr = MerchantRepository.new('./data/merchants_fixture.csv')

    assert_equal "Shopin1901", mr.merchants[0].name
  end
end
