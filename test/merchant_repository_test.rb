require_relative 'test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test

  def test_merchant_repo_exists
    mr = MerchantRepository.new('./data/merchants.csv', self)

    assert_instance_of MerchantRepository, mr
  end

  def test_merchant_repo_has_sales_engine_access
    se = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          :invoices => "./data/invoices.csv",
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

    assert_instance_of Hash, mr.id_repo
    refute mr.id_repo.empty?
    assert_equal 475, mr.id_repo.count
  end

  def test_merchant_repo_can_load_name_repo
    mr = MerchantRepository.new('./data/merchants.csv', self)

    assert_instance_of Hash, mr.name_repo
    refute mr.name_repo.empty?
    assert_equal 475, mr.name_repo.count
  end

  def test_merchant_repo_can_search_all_merchants
    mr = MerchantRepository.new('./data/merchants.csv', self)
    all_merchants = mr.all

    assert_instance_of Array, all_merchants
    refute all_merchants.empty?
    assert_equal 475, all_merchants.count
  end

  def test_merchant_repo_can_find_merchant_by_id
    mr = MerchantRepository.new('./data/merchants.csv', self)
    merchant = mr.find_by_id(12334271)

    assert_instance_of Merchant, merchant
    assert_equal "TheAssemblyRooms", merchant.name
    assert_equal 12334271, merchant.id
  end

  def test_merchant_repo_find_by_id_returns_nil_on_bad_search
    mr = MerchantRepository.new('./data/merchants.csv', self)
    merchant = mr.find_by_id(00000000)

    assert_nil merchant
  end

  def test_merchant_repo_can_find_merchant_by_name
    mr = MerchantRepository.new('./data/merchants.csv', self)
    merchant = mr.find_by_name("necklacemaniac")

    assert_instance_of Merchant, merchant
    assert_equal "Necklacemaniac", merchant.name
    assert_equal 12334986, merchant.id
  end

  def test_merchant_repo_find_by_name_returns_nil_on_bad_search
    mr = MerchantRepository.new('./data/merchants.csv', self)
    merchant = mr.find_by_name("asdlkjads;lf")

    assert_nil merchant
  end

  def test_merchant_repo_can_find_all_by_name
    mr = MerchantRepository.new('./data/merchants.csv', self)
    merchants = mr.find_all_by_name('cool')
    merchants_2 = mr.find_all_by_name('style')

    assert_equal 3, merchants.count
    assert_equal 3, merchants_2.count
  end

  def test_merchant_repo_find_all_by_name_returns_empty_array_on_bad_search
    mr = MerchantRepository.new('./data/merchants.csv', self)
    merchants = mr.find_all_by_name('adsf;lkjsdaf')

    assert_equal [], merchants
  end

  def test_merchant_repo_to_se
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    merchants = se.merchants
    item = merchants.merchant_repo_to_se(12335119)

    assert_instance_of Item, item[0]
  end

  def test_merchant_repo_to_se_invoices
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    merchants = se.merchants
    invoices = merchants.merchant_repo_to_se_invoices(12335119)

    assert_instance_of Invoice, invoices[0]
  end

  def test_merchant_repo_to_se_customers
    se = SalesEngine.from_csv({
      :merchants => './data/merchants.csv',
      :customers => './data/customers.csv',
      :invoices => './data/invoices.csv'
      })
    merchants = se.merchants
    customers = merchants.merchant_repo_to_se_customers(12334194)

    assert_instance_of Customer, customers[0]
    assert_equal 12, customers.length
  end

end
