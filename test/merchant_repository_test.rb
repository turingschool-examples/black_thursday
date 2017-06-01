require "minitest/autorun"
require "minitest/emoji"
require "./lib/merchant_repository"

class MerchantRepositoryTest < Minitest::Test

 def test_new_instance
  mr = MerchantRepository.new("./test/merchants_test.csv",self)

  assert_instance_of MerchantRepository, mr
 end

 def test_access_all_instances
   skip
   mr = MerchantRepository.new("./test/merchants_test.csv",self)
   mr.organize
    binding.pry
   expected = #[<Merchant:0x007fc2de1cbc60 @information={"id"=>"12334105", "name"=>"Shopin1901", "created_at"=>"2010-12-10", "updated_at"=>"2011-12-04"}, @parent=#<MerchantRepository:0x007fc2df095458 @contents=[{"id"=>"12334105", "name"=>"Shopin1901", "created_at"=>"2010-12-10", "updated_at"=>"2011-12-04"}], @file_path="./test/merchants_test.csv", @parent=main>>]

   assert_equal expected, mr.all
 end
end
