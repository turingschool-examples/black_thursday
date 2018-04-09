# frozen_string_literal: true

require './test/test_helper'
require './lib/merchant_repository'
require './lib/merchant'

class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    mr = MerchantRepository.new('./test/fixtures/merchant_fixture.csv')
    assert_instance_of MerchantRepository, mr
  end

  def test_contents_data_type
    mr = MerchantRepository.new('./test/fixtures/merchant_fixture.csv')
    assert_equal Array, mr.contents.class
  end

  def test_items_data_type
    mr = MerchantRepository.new('./test/fixtures/merchant_fixture.csv')
    assert_equal 5, mr.all.count
  end

  def test_find_by_id
    mr = MerchantRepository.new('./test/fixtures/merchant_fixture.csv')
    result = '12334112,Candisart,2009-05-30,2010-08-29'

    assert_equal result, mr.find_by_id(3)
  end
end
