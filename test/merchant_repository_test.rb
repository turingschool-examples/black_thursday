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
end
