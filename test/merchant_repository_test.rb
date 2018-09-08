require_relative '../test/test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def test_it_exists
    ir = MerchantRepository.new
    assert_instance_of MerchantRepository, ir
  end

  def test_has_no_items_to_start
    ir = MerchantRepository.new
    assert_equal [], ir.all
  end

  def test_new_item_added_to_item_array
    ir = MerchantRepository.new
    hash = {
      :id          => 1,
      :name        => "Pencil",
    }
    ir.create(hash)
    assert_instance_of Merchant, ir.all[0]
  end

  def test_it_returns_nil_with_no_matching_id
    ir = MerchantRepository.new
    assert_nil ir.find_all_by_id(1234)
  end

  def test_it_can_return_by_id
    ir = MerchantRepository.new
    hash = {
      :id          => 1,
      :name        => "Pencil",
    }
    ir.create(hash)

    assert_equal "Pencil", ir.find_all_by_id(1).name
  end

end
