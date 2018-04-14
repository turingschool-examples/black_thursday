require './test/test_helper'
require './lib/merchant_repository'
require './lib/merchant'

class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    mr = MerchantRepository.new('./test/fixtures/merchant_fixture.csv', self)
    assert_instance_of MerchantRepository, mr
  end

  def test_it_returns_all_merchants
    mr = MerchantRepository.new('./test/fixtures/merchant_fixture.csv', self)

    assert_equal 5, mr.all.count
    assert_instance_of Array, mr.all
    assert_instance_of Merchant, mr.all[0]
  end

  def test_it_has_id
    mr = MerchantRepository.new('./test/fixtures/merchant_fixture.csv', self)

    assert_nil mr.find_by_id(20)
    assert_instance_of Merchant, mr.find_by_id('12334105')
    assert_equal 'Shopin1901', mr.find_by_id('12334105').name
  end

  def test_find_by_name
    mr = MerchantRepository.new('./test/fixtures/merchant_fixture.csv', self)

    assert_equal 'Shopin1901', mr.find_by_name('Shopin1901').name
    assert_nil mr.find_by_name('morty')
  end

  def test_find_all_by_name
    mr = MerchantRepository.new('./test/fixtures/merchant_fixture.csv', self)


    assert_instance_of Merchant, mr.find_by_name('Candisart')
    assert_equal 12_334_112, mr.find_by_name('Candisart').id
  end
end
