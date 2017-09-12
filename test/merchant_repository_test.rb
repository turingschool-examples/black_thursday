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

    assert_equal 12334105, mr.merchants[0].id
  end

  def test_it_has_the_correct_first_entry_name
    mr = MerchantRepository.new('./data/merchants_fixture.csv')

    assert_equal "Shopin1901", mr.merchants[0].name
  end

  #all - returns an array of all known Merchant instances
  def test_all_returns_all_the_merchants
    mr = MerchantRepository.new('./data/merchants_fixture.csv')

    assert_equal 19, mr.all.count
  end

  # find_by_id - returns either nil or an instance of Merchant with a matching ID
  def test_it_can_find_a_merchant_using_id
    mr = MerchantRepository.new('./data/merchants_fixture.csv')
    id_1 = 12334174
    id_2 = "1"
    id_3 = 101

    assert mr.find_by_id(id_1)
    assert_nil mr.find_by_id(id_2)
    assert_nil mr.find_by_id(id_3)
    #feel like these tests need to be more robust.... but I'm not sure ho
  end

  # find_by_name - returns either nil or an instance of Merchant having done a case insensitive search
  def test_it_can_find_a_merchant_using_name
    mr = MerchantRepository.new('./data/merchants_fixture.csv')
    name_1 = "GoldenRayPress"
    name_2 = "goldenRaypress"
    name_3 = ""
    name_4 = "hi"

    assert mr.find_by_name(name_1)
    assert mr.find_by_name(name_2)
    assert_nil mr.find_by_name(name_3)
    assert_nil mr.find_by_name(name_4)
  end

  # find_all_by_name - returns either [] or one or more matches which contain the supplied name fragment, case insensitive
  def test_it_can_find_all_merchants_with_a_given_name
    mr = MerchantRepository.new('./data/merchants_fixture.csv')
    name_1 = "in"
    name_2 = "Turing School of Software"
    name_3 = "Mo"

    assert_equal 4, mr.find_all_by_name(name_1).length
    assert_equal [], mr.find_all_by_name(name_2)
    assert_equal 3, mr.find_all_by_name(name_3).length
  end

end
