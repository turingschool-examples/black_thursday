# require './test/test_helper'
# require './lib/merchant_repository'
#
#
#
# class MerchantRepositoryTest < Minitest::Test
#
#   attr_reader :merchant_repo
#   def setup
#     @merchant_repo = Fixture.repo(:merchants)
#   end
#
#   def test_that_an_instance_exits
#     assert_instance_of MerchantRepository, merchant_repo
#   end
#
#   def test_all_returns_an_array_of_all_merchant_instances
#     assert_instance_of Array, merchant_repo.all
#     assert_instance_of Merchant, merchant_repo.all.first
#   end
#
#   def test_find_by_id_returns_nil_if_no_matching_id
#     assert_nil merchant_repo.find_by_id(34)
#   end
#
#   def test_find_by_name_returns_merchant_instance
#     merchant = merchant_repo.find_by_id(4)
#     assert_instance_of Merchant, merchant
#
#     assert_equal 4, merchant.id
#   end
#
#   def test_find_by_name_returns_nil_if_no_match
#     assert_nil merchant_repo.find_by_name("Happy")
#   end
#
#   def test_find_by_name_returns_matching_instance
#     merchant = merchant_repo.find_by_name("merchant 4")
#     assert_instance_of Merchant, merchant
#
#     assert_equal "merchant 4", merchant.name
#   end
#
#   def test_find_by_name_returns_matching_instance_no_matter_case
#     merchant = merchant_repo.find_by_name("mErchaNt 4")
#     assert_instance_of Merchant, merchant
#
#     assert_equal "merchant 4", merchant.name
#   end
#
#   def test_find_by_name_returns_matching_instance_with_all_caps
#     merchant = merchant_repo.find_by_name("MERCHANT 4")
#     assert_instance_of Merchant, merchant
#
#     assert_equal "merchant 4", merchant.name
#   end
#
#   def test_find_all_by_name_returns_empty_array_if_no_matches
#     assert_equal [], merchant_repo.find_all_by_name("Happy")
#   end
#
#   def test_find_all_by_name_returns_all_that_match
#     assert_equal 5, merchant_repo.find_all_by_name("merchant").count
#     assert_equal 6, merchant_repo.find_all_by_name("chant").count
#   end
#
#   def test_find_all_by_name_returns_all_that_match_case_insensitive
#     assert_equal 5, merchant_repo.find_all_by_name("merCHANT").count
#   end
#
# end
