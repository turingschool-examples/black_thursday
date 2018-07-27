# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'

require './lib/merchant_repository'

# Merchant repository test class
class MerchantRepositoryTest < Minitest::Test
  def setup
    @mr = MerchantRepository.new
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_it_creates_new_merchant_instance
    actual = @mr.create(id: 5, name: 'Turing School')

    assert_instance_of Merchant, actual
  end

  def test_it_returns_array_of_all_merchants
    created = @mr.create(id: 5, name: 'Turing School')

    assert_equal [created], @mr.all
  end

  def test_it_can_find_by_id
    created = @mr.create(id: 5, name: 'Turing School')

    assert_equal created, @mr.find_by_id(5)
  end

  def test_it_can_find_by_name
    created = @mr.create(id: 5, name: 'Turing School')

    assert_equal created, @mr.find_by_name('Turing School')
  end

  def test_it_can_find_all_by_name
    created1 = @mr.create(id: 5, name: 'Turing School')
    created2 = @mr.create(id: 12, name: 'turing store')
    created3 = @mr.create(id: 888, name: 'BoutiqueTuring')
    @mr.create(id: 1115, name: 'Kmart')

    expected = [created1, created2, created3]

    assert_equal expected, @mr.find_all_by_name('Turing')
  end

  def test_it_can_update_a_merchant
    @mr.create(id: 5, name: 'Turing School')

    expected = @mr.update(5, name: 'Turing School of Software & Design')
    actual   = @mr.find_by_name('Turing School of Software & Design')

    assert_equal expected, actual
  end

  def test_it_can_delete_merchants
    created = @mr.create(id: 5, name: 'Turing School')

    assert_equal created, @mr.delete(5)
    assert_equal [], @mr.all
  end
end
