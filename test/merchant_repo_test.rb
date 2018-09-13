require 'pry'
require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/csv_adaptor'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repo'

class MerchantRepoTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({
      :items     => "./data/sample_item_data.csv",
      :merchants => "./data/sample_merchant_file.csv"
    })
    mr = se.merchants

    assert_instance_of MerchantRepo, mr
  end

  def test_all_merchant_characteristics_returns_array_of_merchant_characteristics
    engine = SalesEngine.from_csv({
      :items     => "./data/sample_item_data.csv",
      :merchants => "./data/sample_merchant_file.csv"
    })
    mr = engine.merchants

    assert_instance_of Array, mr.all
  end

  def test_all_returns_array_of_merchant_objects
    engine = SalesEngine.from_csv({
      :items     => "./data/sample_item_data.csv",
      :merchants => "./data/sample_merchant_file.csv"
    })
    mr = engine.merchants

    assert_instance_of Array, engine.merchants.all
  end

  def test_find_by_id_returns_merchant_id
    se = SalesEngine.from_csv({
      :items     => "./data/sample_item_data.csv",
      :merchants => "./data/sample_merchant_file.csv"
    })
    mr = se.merchants
    mr.all
    id = 12334115
    expected = mr.merchants[3]

    assert_equal expected, mr.find_by_id(id)
  end

  def test_find_by_name_returns_merchant_name
    se = SalesEngine.from_csv({
      :items     => "./data/sample_item_data.csv",
      :merchants => "./data/sample_merchant_file.csv"
    })
    mr = se.merchants
    mr.all
    name = "LolaMarleys"
    expected = mr.merchants[3]

    assert_equal expected, mr.find_by_name(name)
  end

  def test_it_returns_nil_when_name_or_id_dont_exist
    se = SalesEngine.from_csv({
      :items     => "./data/sample_item_data.csv",
      :merchants => "./data/sample_merchant_file.csv"
    })
    mr = se.merchants
    mr.all
    name = "amy"
    id = "12345"

    assert_equal nil, mr.find_by_name(name)
    assert_equal nil, mr.find_by_id(id)
  end

  def test_find_all_by_name_returns_merchants_with_name_fragment
    se = SalesEngine.from_csv({
      :items     => "./data/sample_item_data.csv",
      :merchants => "./data/sample_merchant_file.csv"
    })
    mr = se.merchants
    mr.all
    name = "kec"

    assert_equal 3, mr.find_all_by_name(name).length
  end

  def test_find_highest_merchant_id
    se = SalesEngine.from_csv({
      :items     => "./data/sample_item_data.csv",
      :merchants => "./data/sample_merchant_file.csv"
    })
    mr = se.merchants
    mr.all

    assert_equal 1233411111, mr.find_highest_merchant_id
  end

  def test_create_creates_new_instance_of_merchant
    se = SalesEngine.from_csv({
      :items     => "./data/sample_item_data.csv",
      :merchants => "./data/sample_merchant_file.csv"
    })
    mr = se.merchants
    mr.all
    attributes = {name: "Amy", created_at: "2018-09-08"}

    assert_instance_of Merchant, mr.create(attributes)
  end

  def test_you_can_update_name_attribute_accessing_through_id
    se = SalesEngine.from_csv({
      :items     => "./data/sample_item_data.csv",
      :merchants => "./data/sample_merchant_file.csv"
    })
    mr = se.merchants
    mr.all
    id = 12334112
    obj = mr.find_by_id(id)
    attributes = {name: "TEST_NAME"}
    mr.update(id, attributes)

    assert_equal "TEST_NAME", obj.name
  end

  def test_delete_id_deletes_merchant_object_from_merchant_array
    se = SalesEngine.from_csv({
      :items     => "./data/sample_item_data.csv",
      :merchants => "./data/sample_merchant_file.csv"
    })
    mr = se.merchants
    mr.all
    merchant = mr.find_by_id(12334105)
    mr.delete(12334105)

    refute mr.merchants.include?(merchant)
  end

end
