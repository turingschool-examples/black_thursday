require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository.rb'
require_relative '../lib/merchant.rb'

class MerchantRepositoryTest < MiniTest::Test
  attr_reader :merchant_repository

  def setup
    merchant_helper = TestHelper.new.merchants
    @merchant_repository = MerchantRepository.new(merchant_helper)
  end

  def test_it_initializes_with_correct_id
    assert_equal 12334115, merchant_repository.merchants[0].id
    assert_equal 12334135, merchant_repository.merchants[1].id
  end

  def test_it_finds_all_by_id
    assert_equal [12334115, 12334135], all_ids
  end

  def test_it_finds_by_id
    assert_equal 12334135, merchant_repository.find_by_id(12334135).id
  end

  def test_it_finds_by_name
    assert_equal "LolaMarleys", merchant_repository.find_by_name("LolaMarleys").name
  end

  def test_it_finds_all_by_name
    assert_equal ["LolaMarleys","GoldenRayPress"], all_names
  end

  def test_it_can_be_inspected
    assert_equal "#<MerchantRepository 2 rows>", merchant_repository.inspect
  end

  private

  def all_names
    merchant_repository.find_all_by_name.map do |merchant|
      merchant.name
    end
  end

  def all_ids
    merchant_repository.all.map do |merchant|
      merchant.id
    end
  end
end
