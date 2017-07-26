require 'simplecov'

gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'
require './lib/sales_engine'
require './lib/merchant'

class MerchantRepositoryTest < Minitest::Test

  def test_merchant_repo_exists
    mr = MerchantRepository.new('./data/merchants.csv', self)

    assert_instance_of MerchantRepository, mr
  end

  def test_merchant_repo_has_sales_engine_access
    se = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
        })
    mr = se.merchants

    assert_instance_of SalesEngine, mr.sales_engine
  end

  def test_merchant_repo_has_file_path
    mr = MerchantRepository.new('./data/merchants.csv', self)

    assert_equal './data/merchants.csv', mr.file_path
  end

  def test_merchant_repo_can_load_id_repository
    mr = MerchantRepository.new('./data/merchants.csv', self)
    mr.load_repo

    assert_instance_of Hash, mr.id_repo
    refute mr.id_repo.empty?
    assert_equal 475, mr.id_repo.count
  end

  def test_merhcant_repo_can_load_name_repo
    mr = MerchantRepository.new('./data/merchants.csv', self)
    mr.load_repo

    assert_instance_of Hash, mr.name_repo
    refute mr.name_repo.empty?
    assert_equal 475, mr.name_repo.count
  end

end

#   def test_initialize
#     file_path = "./data/merchants.csv"
#     salesengine = SalesEngine.from_csv({
#       :items     => "./data/items.csv",
#       :merchants => "./data/merchants.csv",
#     })
#     merchantrepo = MerchantRepository.new(file_path, salesengine)
#
#     assert_instance_of MerchantRepository, merchantrepo
#     assert_instance_of SalesEngine, merchant.salesengine
#   end
#
#   def test_all
#     file_path = "./data/merchants.csv"
#     salesengine = SalesEngine.from_csv({
#       :items     => "./data/items.csv",
#       :merchants => "./data/merchants.csv",
#     })
#     merchantrepo = MerchantRepository.new(file_path, salesengine)
#
#     assert_equal 475, merchantrepo.all.count
#     assert_instance_of Merchant, merchantrepo.all[0]
#   end
#
#   def test_find_by_id_positive
#     file_path = "./data/merchants.csv"
#     salesengine = SalesEngine.from_csv({
#       :items     => "./data/items.csv",
#       :merchants => "./data/merchants.csv",
#     })
#     merchantrepo = MerchantRepository.new(file_path, salesengine)
#
#     merchant = merchantrepo.find_by_id(12337199)
#     assert_instance_of Merchant, merchant
#     assert_equal 12337199, merchant.id
#   end
#
#   def test_find_by_id_negative
#     file_path = "./data/merchants.csv"
#     salesengine = SalesEngine.from_csv({
#       :items     => "./data/items.csv",
#       :merchants => "./data/merchants.csv",
#     })
#     merchantrepo = MerchantRepository.new(file_path, salesengine)
#
#     merchant = merchantrepo.find_by_id(2394023094820)
#     assert_instance_of NilClass, merchant
#   end
#
#   def test_find_by_name_positive
#     file_path = "./data/merchants.csv"
#     salesengine = SalesEngine.from_csv({
#       :items     => "./data/items.csv",
#       :merchants => "./data/merchants.csv",
#     })
#     merchantrepo = MerchantRepository.new(file_path, salesengine)
#
#     merchant = merchantrepo.find_by_name("etsygb")
#     assert_instance_of Merchant, merchant
#     assert_equal "EtsyGB", merchant.name
#   end
#
#   def test_find_by_name_negative
#     file_path = "./data/merchants.csv"
#     salesengine = SalesEngine.from_csv({
#       :items     => "./data/items.csv",
#       :merchants => "./data/merchants.csv",
#     })
#     merchantrepo = MerchantRepository.new(file_path, salesengine)
#
#     merchant = merchantrepo.find_by_name("EEEEEEEEEEEYYYYYYYYthere")
#     assert_instance_of NilClass, merchant
#   end
#
#   def test_find_by_name_all
#     file_path = "./data/merchants.csv"
#     salesengine = SalesEngine.from_csv({
#       :items     => "./data/items.csv",
#       :merchants => "./data/merchants.csv",
#     })
#     merchantrepo = MerchantRepository.new(file_path, salesengine)
#
#     merchants = merchantrepo.find_by_name_all("e")
#     assert_instance_of Array, merchants
#     assert_instance_of Merchant, merchants[0]
#   end
#
#   def test_find_by_name_all_negative
#     file_path = "./data/merchants.csv"
#     salesengine = SalesEngine.from_csv({
#       :items     => "./data/items.csv",
#       :merchants => "./data/merchants.csv",
#     })
#     merchantrepo = MerchantRepository.new(file_path, salesengine)
#
#     merchants = merchantrepo.find_by_name_all("WREFwerfwerWHTRytg")
#     assert_instance_of Array, merchants
#     assert merchants.empty?
#   end
#
