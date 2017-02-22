require_relative 'test_helper.rb'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    mr = MerchantRepository.new

    assert_instance_of MerchantRepository, mr
  end

  def test_it_creates_new_instance_of_merchant
    mr = MerchantRepository.new(CSV.open "./data/temp_merchants.csv", headers: true, header_converters: :symbol)

    assert_instance_of Merchant, mr.create_merchant_instances
  end

end
