require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'
require_relative './test_helper'


class MerchantRepositoryTest < Minitest::Test
  def setup
    @merchants =
      [{id: '12334105',
      name: 'Shopin1901',
      created_at: '2010-12-10',
      updated_at: '2011-12-04'},
      {id: '12334112',
      name: 'Candisart',
      created_at: '2009-05-30',
      updated_at: '2010-08-29'},
      {id: '12334113',
      name: 'MiniatureBikez',
      created_at: '2010-03-30',
      updated_at: '2013-01-21'}]

    @merchant_repository = MerchantRepository.new(@merchants)
  end

  def test_it_exist
    assert_instance_of MerchantRepository, @merchant_repository
  end

  def test_it_can_build_merchant
    assert_equal Array, @merchant_repository.build_merchant(@merchants).class
  end

  def test_can_get_an_array_of_merchants
    assert_equal 3, @merchant_repository.all.count
  end
end
