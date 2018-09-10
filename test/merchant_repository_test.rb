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

  def test_it_can_add_by_string
    ir = MerchantRepository.new
    hash = {
      :id          => 1,
      :name        => "Pencil",
    }
    ir.create(hash)
    ir.create("Pencil")
    assert_equal 2, ir.all.length
  end

  def test_it_returns_nil_with_no_matching_id
    ir = MerchantRepository.new
    hash = {
      :id          => 1,
      :name        => "Pencil",
    }
    ir.create(hash)
    assert_nil ir.find_by_id(1234)
  end

  def test_it_can_return_by_id
    ir = MerchantRepository.new
    hash = {
      :id          => 1,
      :name        => "Pencil",
    }
    ir.create(hash)
    assert_equal "Pencil", ir.find_by_id(1).name
  end

  def test_it_returns_nil_with_no_matching_names
    ir = MerchantRepository.new
    hash = {
      :id          => 1,
      :name        => "Pencil",
    }
    ir.create(hash)
    assert_nil ir.find_by_name("Water Buffalo")
  end

  def test_it_can_return_by_name
    ir = MerchantRepository.new
    hash = {
      :id          => 1,
      :name        => "Pencil",
    }
    ir.create(hash)
    assert_equal "Pencil", ir.find_by_name("Pencil").name
  end

  def test_it_returns_an_empty_array_with_no_name_matches
    ir = MerchantRepository.new
    hash = {
      :id          => 1,
      :name        => "Pencil",
    }
    ir.create(hash)
    assert_equal [], ir.find_all_by_name("Water Buffalo")
  end

  def test_it_can_find_all_by_name_fragment
    ir = MerchantRepository.new
    hash = {
      :id          => 1,
      :name        => "Pencil",
    }
    ir.create(hash)
    assert_equal 1, ir.find_all_by_name("pen").length
  end

  def test_it_can_find_next_id
    ir = MerchantRepository.new
    hash = {
      :id          => 1,
      :name        => "Pencil",
    }
    ir.create(hash)
    assert_equal 2, ir.find_next_id
  end

  def test_it_can_update_name
    ir = MerchantRepository.new
    hash = {
      :id          => 1,
      :name        => "Pencil",
    }
    ir.create(hash)
    ir.update(1, "Eraser")
    assert_equal "Eraser", ir.all[0].name
  end

  def test_merchant_can_be_deleted
    ir = MerchantRepository.new
    hash = {
      :id          => 1,
      :name        => "Pencil",
    }
    hash2 = {
      :id          => 2,
      :name        => "Eraser",
    }
    ir.create(hash)
    ir.create(hash2)
    ir.delete(2)
    assert_equal 1, ir.all.length
  end

  def test_it_will_do_nothing_when_trying_to_delete_nonexistant_id
    ir = MerchantRepository.new
    hash = {
      :id          => 1,
      :name        => "Pencil",
    }
    hash2 = {
      :id          => 2,
      :name        => "Eraser",
    }
    ir.create(hash)
    ir.create(hash2)
    ir.delete(3)
    assert_equal 2, ir.all.length
  end
end
