require './test_helper'
require './lib/merchant'
require './lib/merchant_repository'

class MerchantRepositoryTest < MiniTest::Test
  def test_it_exists
    mr = MerchantRepository.new

    assert_instance_of MerchantRepository, mr
  end

  def test_merchants_starts_as_an_empty_array
    mr = MerchantRepository.new

    assert_equal [], mr.all
  end

  def test_it_can_create_merchants
    mr = MerchantRepository.new
    attributes = {:id => 5, :name => 'Turing School'}
    mr.create(attributes)

    assert_equal 5, mr.all.first.id
    assert_equal 'Turing School', mr.all.first.name
  end

  def test_it_can_return_merchant_by_its_id

  end
end
