- load all merchants from CSV
- all: returns array of all merchant instances
- find_by_id: returns either nil or an instance of Merchant with a matching ID
- find_by_name: returns either nil or an instance of Merchant having done a case insensitive search
- find_all_by_name: returns either [] or one or more matches which contain the supplied name fragment, case insensitive

class MerchantRepositoryTest < Minitest::Test
  def test_initialize
    file_path = "./data/merchants.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    merchantrepo = MerchantRepository.new(file_path, salesengine)

    assert_instance_of MerchantRepository, merchantrepo
    assert_instance_of SalesEngine, merchant.salesengine
  end

  def test_all
    file_path = "./data/merchants.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    merchantrepo = MerchantRepository.new(file_path, salesengine)

    assert_equal 475, merchantrepo.all.count
    assert_instance_of Merchant, merchantrepo.all[0]
  end

  def test_find_by_id_positive
    file_path = "./data/merchants.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    merchantrepo = MerchantRepository.new(file_path, salesengine)

    merchant = merchantrepo.find_by_id(12337199)
    assert_instance_of Merchant, merchant
    assert_equal 12337199, merchant.id
  end

  def test_find_by_id_negative
    file_path = "./data/merchants.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    merchantrepo = MerchantRepository.new(file_path, salesengine)

    merchant = merchantrepo.find_by_id(2394023094820)
    assert_instance_of NilClass, merchant
  end

  def test_find_by_name_positive
    file_path = "./data/merchants.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    merchantrepo = MerchantRepository.new(file_path, salesengine)

    merchant = merchantrepo.find_by_name("etsygb")
    assert_instance_of Merchant, merchant
    assert_equal "EtsyGB", merchant.name
  end

  def test_find_by_name_negative
    file_path = "./data/merchants.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    merchantrepo = MerchantRepository.new(file_path, salesengine)

    merchant = merchantrepo.find_by_name("EEEEEEEEEEEYYYYYYYYthere")
    assert_instance_of NilClass, merchant
  end

  def test_find_by_name_all
    file_path = "./data/merchants.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    merchantrepo = MerchantRepository.new(file_path, salesengine)

    merchants = merchantrepo.find_by_name_all("e")
    assert_instance_of Array, merchants
    assert_instance_of Merchant, merchants[0]
  end

  def test_find_by_name_all_negative
    file_path = "./data/merchants.csv"
    salesengine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    merchantrepo = MerchantRepository.new(file_path, salesengine)

    merchants = merchantrepo.find_by_name_all("WREFwerfwerWHTRytg")
    assert_instance_of Array, merchants
    assert merchants.empty?
  end
