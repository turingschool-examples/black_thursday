require "minitest/autorun"
require "minitest/pride"
require "./lib/merchant_repository"
require "simplecov"
SimpleCov.start

class MerchantRepositoryTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_three.csv'})
    mr = se.merchants

    assert_instance_of MerchantRepository, mr
  end

  def test_it_has_method_all
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_three.csv'})
    mr = se.merchants

    assert_instance_of Array, mr.all
    assert_equal 3, mr.all.length
    assert_equal "Shopin1901",mr.all.first.name
  end

  def test_it_can_find_merchant_by_id
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_three.csv'})
    mr = se.merchants

    assert_equal "Candisart", mr.find_by_id(12334112).name
  end

  def test_find_by_id_returns_nil_if_merchant_doesnt_exist
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_three.csv'})
    mr = se.merchants

    assert_nil mr.find_by_id(12334115)
  end

  def test_it_can_find_merchant_by_name
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_three.csv'})
    mr = se.merchants

    assert_equal 12334112, mr.find_by_name('Candisart').id
  end


  def test_find_by_name_returns_nil_if_merchant_doesnt_exist
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_three.csv'})
    mr = se.merchants
    
    assert_nil mr.find_by_name('Jasmin')
  end

  def test_find_all_by_name
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_three.csv'})
    mr = se.merchants

    assert_equal Array, mr.find_all_by_name("in").class
    assert_equal 2, mr.find_all_by_name("in").length
    assert_equal "Shopin1901", mr.find_all_by_name("in").first.name
  end

  def test_find_all_by_name_returns_empty_array_if_doesnt_exist
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_three.csv'})
    mr = se.merchants

    assert_equal [], mr.find_all_by_name("banana")
  end

  def test_parent_is_instance_of_sales_engine
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_three.csv'})
    mr = se.merchants
    
    assert_instance_of SalesEngine, mr.parent
  end

end