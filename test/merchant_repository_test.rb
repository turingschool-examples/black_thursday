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
    assert_equal 6, mr.all.count
  end

  def test_it_finds_by_id
    mr = MerchantRepository.new('./test/fixtures/merchant_fixture.csv')
    assert_equal '12334112', mr.find_by_id('12334112').id
  end

  def test_it_finds_by_name
    mr = MerchantRepository.new('./test/fixtures/merchant_fixture.csv')
    assert_equal 'Candisart', mr.find_by_name('Candisart').name
  end

  def test_it_finds_all_by_name
    mr = MerchantRepository.new('./test/fixtures/merchant_fixture.csv')
    assert_equal 2, mr.find_all_by_name('Candisart').count
  end

  def test_it_create_and_id_the_new_merchant
        mr = MerchantRepository.new('./test/fixtures/merchant_fixture.csv')
        assert_equal 12334567, mr.create("Sabrina")
  end

end
