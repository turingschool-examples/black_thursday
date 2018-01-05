require "./test/test_helper"
require "./lib/merchant_repository"

class MerchantRepositoryTest < MiniTest::Test

  def setup
    @merchants = MerchantRepository.new("./test/fixtures/merchants_fixtures.csv")
  end

  def test_all_returns_merchants
    assert_equal @merchants.merchants.values, @merchants.all
  end

  def test_find_by_id_is_nil_when_passed_non_matching_id
    assert_nil @merchants.find_by_id(2)
  end

  def test_find_by_id_returns_instance_of_merchant
    assert_instance_of Merchant, @merchants.find_by_id(12335521)

    assert_equal 12335521, @merchants.find_by_id(12335521).id
  end

  def test_find_by_id_only_accepts_integers
    assert_raises ArgumentError do
      @merchants.find_by_id("l")
    end

    assert_raises ArgumentError do
      @merchants.find_by_id(["a", "b"])
    end
  end

  def test_find_by_name_returns_instance_of_merchant
    assert_instance_of Merchant, @merchants.find_by_name("IvyMoonCat")

    assert_equal "IvyMoonCat", @merchants.find_by_name("IvyMoonCat").name
  end

  def test_find_by_name_only_accepts_strings
    assert_raises ArgumentError do
      @merchants.find_by_name(1)
    end

    assert_raises ArgumentError do
      @merchants.find_by_name(["a", "b"])
    end
  end

  def test_find_all_by_name_returns_an_array_of_all_instances_of_merchant
    assert_instance_of Array, @merchants.find_all_by_name("art")

    assert_instance_of Merchant, @merchants.find_all_by_name("art")[0]
  end

  def test_find_all_by_name_returns_empty_array_when_none_found
    assert_equal [], @merchants.find_all_by_name("adsfadsfd")
  end


  def test_find_all_by_name_only_accepts_strings
    assert_raises ArgumentError do
      @merchants.find_all_by_name(1)
    end

    assert_raises ArgumentError do
      @merchants.find_all_by_name(["a", "b"])
    end
  end

  def test_csv_opener_only_accepts_strings
    assert_raises ArgumentError do
      @merchants.csv_opener(1)
    end

    assert_raises ArgumentError do
      @merchants.csv_opener(["a", "b"])
    end
  end

  def test_merchant_creator_and_storer_only_accepts_strings
    assert_raises ArgumentError do
      @merchants.merchant_creator_and_storer(1)
    end

    assert_raises ArgumentError do
      @merchants.merchant_creator_and_storer(["a", "b"])
    end
  end

  def test_argument_raiser_raises_argument_when_passed_a_float
    assert_raises ArgumentError do
      @merchants.argument_raiser(0.2)
    end
  end
end
