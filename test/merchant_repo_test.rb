equire 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repo'

class MerchantRepoTest < Minitest::Test

  def test_it_exists
    assert MerchantRepo.new("items.csv")
  end

  def test_it_has_a_class
    m = MerchantRepo.new({:id => "Blue purse"})
    assert_equal MerchantRepo, i.class
  end

  def test_it_can_display_all_items
  end

  def test_it_can_search_by_id
  end

  def test_it_can_find_by_name
  end

  def test_it_can_can_find_by_description
  end

  def test_it_can_find_by_price
  end

  def test_it_can_find_by_price_in_range
  end

  def test_it_can_find_by_merchant_id
  end

end
