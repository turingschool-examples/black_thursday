require_relative "test_helper.rb"
require_relative "../lib/merchant_repository"

class MerchantRepositoryTest < Minitest::Test

 def test_new_instance
  mr = MerchantRepository.new("./test/data/merchant_fixture.csv",self)

  assert_instance_of MerchantRepository, mr
 end

 def test_return_all_instances
   mr = MerchantRepository.new("./test/data/merchant_fixture.csv",self)
   expected = [12334105, 12334112, 12334113, 12334115, 12334123, 12334132, 12334135]
   result = mr.all
   actual = []
   result.each { |m| actual << m.id }

   assert_equal expected, actual
 end

 def test_find_by_id_with_good_id
   mr = MerchantRepository.new("./test/data/merchant_fixture.csv",self)
   actual = mr.find_by_id(12334105).id
   assert_equal 12334105, actual
 end

 def test_find_by_id_with_bad_id
   mr = MerchantRepository.new("./test/data/merchant_fixture.csv",self)

   assert_nil mr.find_by_id("345")
 end

 def test_find_by_name_good_name
   mr = MerchantRepository.new("./test/data/merchant_fixture.csv",self)
   actual = mr.find_by_name("keckenbauer").name
   assert_equal "Keckenbauer", actual
 end

 def test_find_by_name_bad_name
   mr = MerchantRepository.new("./test/data/merchant_fixture.csv",self)

   assert_nil mr.find_by_name("store")
 end

 def test_find_all_by_name_good_name
   mr = MerchantRepository.new("./test/data/merchant_fixture.csv",self)
   find = mr.find_all_by_name("in")
   actual = find[0][0], find[1][0]

   assert_equal [12334105, 12334113], actual
 end

 def test_find_all_by_name_bad_name
   mr = MerchantRepository.new("./test/data/merchant_fixture.csv",self)

   assert_equal [], mr.find_all_by_name(" ")
 end

end
