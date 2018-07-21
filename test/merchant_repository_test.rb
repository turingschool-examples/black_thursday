require './test/test_helper'
require './lib/file_loader'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  include FileLoader

  def setup
    @mr = MerchantRepository.new(load_file('./data/merchants.csv'))
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_all
    assert_instance_of Array, @mr.merchant_repo
    assert_instance_of Merchant, @mr.merchant_repo[0]
    assert_equal 475, @mr.merchant_repo.count
  end

  def test_find_by_id
    assert_equal @mr.all[0], @mr.find_by_id(12334105)
  end


end
