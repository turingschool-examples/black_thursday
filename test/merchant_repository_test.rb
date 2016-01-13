require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def setup
    csv_object_of_merchants = CSV.open './data/merchants.csv', headers: true, header_converters: :symbol
    @mr = MerchantRepository.new(csv_object_of_merchants)
  end

  def test_can_create_a_repo_of_merchants
    # confirm we're getting objects for all 475 merchants
    assert_equal 475, @mr.all.count
    # confirm we have the id for the first merchant
    assert_equal 12334105, @mr.all[0].id
    # confirm we have the id for the last merchant
    assert_equal 12337411, @mr.all[-1].id
  end

  def test_all_merchants
    assert_equal 475, @mr.all.count
  end

  def test_find_by_name
    merchant_name = "Shopin1901"
    expected      = merchant_name
    submitted     = @mr.find_by_name(merchant_name)

    assert_equal expected, submitted.name
  end

  def test_find_by_name_insensitve_search
    merchant_name = "Shopin1901"
    expected      = merchant_name
    submitted     = @mr.find_by_name(merchant_name.upcase)

    assert_equal expected, submitted.name
  end

  def test_find_by_name_rejects_bad_name
    merchant_name = "BurgerKing"
    submitted     = @mr.find_by_name(merchant_name)

    assert_nil submitted
  end

  def test_find_by_id
    merchant_id = 12334132
    expected    = merchant_id
    submitted   = @mr.find_by_id(merchant_id)

    assert_equal expected, submitted.id
  end

  def test_find_by_id_rejects_bad_id
    merchant_id = 1
    expected    = merchant_id
    submitted   = @mr.find_by_id(merchant_id)

    assert_nil submitted
  end

end
