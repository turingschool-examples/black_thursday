require './test/test_helper'
require './lib/merchant_repository'
require './lib/merchant'

class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    mr = MerchantRepository.new('./test/fixtures/merchant_fixture.csv', self)
    assert_instance_of MerchantRepository, mr
  end

  def test_contents_data_type
    mr = MerchantRepository.new('./test/fixtures/merchant_fixture.csv', self)
    assert_equal Array, mr.contents.class
  end

  def test_items_data_type
    mr = MerchantRepository.new('./test/fixtures/merchant_fixture.csv', self)
    assert_equal 5, mr.all.count
  end

  def test_it_has_id
    mr = MerchantRepository.new('./test/fixtures/merchant_fixture.csv', self)

    assert '12334112', mr.contents[2].id
  end

  def test_it_returns_row_of_a_given_id
    mr = MerchantRepository.new('./test/fixtures/merchant_fixture.csv', self)

    assert_equal '12334112', mr.find_by_id('12334112').id
  end

  def test_it_returns_row_of_a_given_name
    mr = MerchantRepository.new('./test/fixtures/merchant_fixture.csv', self)

    assert_equal 'Candisart', mr.find_by_name('Candisart').name
  end
end
