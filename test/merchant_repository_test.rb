require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def setup
    @time_1 = '1993-10-28 11:56:40 UTC'

    @time_2 = '1993-09-29 12:45:30 UTC'

    @raw_data = [{id:          '123',
                  name:        'testname',
                  created_at:  @time_1,
                  updated_at:  @time_2},
                 {id:          '321',
                  name:        'secondname',
                  created_at:  @time_2,
                  updated_at:  @time_1}]

    @repo = MerchantRepository.new(@raw_data)
  end

  def test_it_exists
    assert_instance_of(MerchantRepository, @repo)
  end

  def test_it_can_display_items
    merchants = @repo.merchants
    assert_instance_of(Array, merchants)
    assert(merchants.all? {|merchant| merchant.class == Merchant})
    assert_equal(321, merchants[1].id)
  end

end
