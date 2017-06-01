require "minitest/autorun"
require "minitest/emoji"
require "./lib/merchant_repository"

class MerchantRepositoryTest < Minitest::Test

 def test_new_instance

  mr = MerchantRepository.new("./test/data/merchant_fixture.csv",self)
binding.pry
  assert_instance_of MerchantRepository, mr
 end

end
