require_relative '../test/test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def setup
    @mr = MerchantRepository.new
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_has_no_items_to_start
    assert_equal [], @mr.all
  end

  def test_new_item_added_to_item_array
    hash = {
      :id          => 1,
      :name        => 'Pencil',
      :created_at  => '2016-01-11 09:34:06 UTC'
    }
    @mr.create(hash)
    assert_instance_of Merchant, @mr.all[0]
  end

  def test_it_can_add_without_id
    hash = {
      :id          => 1,
      :name        => 'Pencil',
      :created_at  => '2016-01-11 09:34:06 UTC'
    }
    @mr.create(hash)
    @mr.create({name: 'Eraser'})
    assert_equal 2, @mr.all.length
  end

  def test_it_returns_nil_with_no_matching_id
    hash = {
      :id          => 1,
      :name        => 'Pencil',
      :created_at  => '2016-01-11 09:34:06 UTC'
    }
    @mr.create(hash)
    assert_nil @mr.find_by_id(1234)
  end

  def test_it_can_return_by_id
    hash = {
      :id          => 1,
      :name        => 'Pencil',
      :created_at  => '2016-01-11 09:34:06 UTC'
    }
    @mr.create(hash)
    assert_equal 'Pencil', @mr.find_by_id(1).name
  end

  def test_it_returns_nil_with_no_matching_names
    hash = {
      :id          => 1,
      :name        => 'Pencil',
      :created_at  => '2016-01-11 09:34:06 UTC'
    }
    @mr.create(hash)
    assert_nil @mr.find_by_name('Water Buffalo')
  end

  def test_it_can_return_by_name
    hash = {
      :id          => 1,
      :name        => 'Pencil',
      :created_at  => '2016-01-11 09:34:06 UTC'
    }
    @mr.create(hash)
    assert_equal 'Pencil', @mr.find_by_name('Pencil').name
  end

  def test_it_returns_an_empty_array_with_no_name_matches
    hash = {
      :id          => 1,
      :name        => 'Pencil',
      :created_at  => '2016-01-11 09:34:06 UTC'
    }
    @mr.create(hash)
    assert_equal [], @mr.find_all_by_name('Water Buffalo')
  end

  def test_it_can_find_all_by_name_fragment
    hash = {
      :id          => 1,
      :name        => 'Pencil',
      :created_at  => '2016-01-11 09:34:06 UTC'
    }
    @mr.create(hash)
    assert_equal 1, @mr.find_all_by_name('pen').length
  end

  def test_it_can_find_next_id
    hash = {
      :id          => 1,
      :name        => 'Pencil',
      :created_at  => '2016-01-11 09:34:06 UTC'
    }
    @mr.create(hash)
    assert_equal 2, @mr.find_next_id
  end

  def test_id_starts_at_0
    assert_equal 1, @mr.find_next_id
  end

  def test_it_can_update_name
    hash = {
      :id          => 1,
      :name        => 'Pencil',
      :created_at  => '2016-01-11 09:34:06 UTC'
    }
    @mr.create(hash)
    @mr.update(1, {name: 'Eraser'})
    assert_equal 'Eraser', @mr.all[0].name
  end

  def test_merchant_can_be_deleted
    hash = {
      :id          => 1,
      :name        => 'Pencil',
      :created_at  => '2016-01-11 09:34:06 UTC'
    }
    hash2 = {
      :id          => 2,
      :name        => 'Eraser',
      :created_at  => '2016-01-11 09:34:06 UTC'
    }
    @mr.create(hash)
    @mr.create(hash2)
    @mr.delete(2)
    assert_equal 1, @mr.all.length
  end

  def test_it_will_do_nothing_when_trying_to_delete_nonexistant_id
    hash = {
      :id          => 1,
      :name        => 'Pencil',
      :created_at  => '2016-01-11 09:34:06 UTC'
    }
    hash2 = {
      :id          => 2,
      :name        => 'Eraser',
      :created_at  => '2016-01-11 09:34:06 UTC'
    }
    @mr.create(hash)
    @mr.create(hash2)
    @mr.delete(3)
    assert_equal 2, @mr.all.length
  end
end
