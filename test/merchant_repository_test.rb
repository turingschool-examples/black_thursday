require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository.rb'
require_relative '../lib/merchant.rb'


class MerchantRepositoryTest < MiniTest::Test
  attr_reader :mr

  def setup
    @mr = MerchantRepository.new([{ :id => "12334115", :name => "LolaMarleys"}, {:id => "12334135", :name => "GoldenRayPress"}])
  end

  def test_it_initializes_with_correct_id
    assert_equal 12334115, mr.merchants[0].id
    assert_equal 12334135, mr.merchants[1].id
  end

   def test_it_finds_all_by_id
    assert_equal [12334115, 12334135], all_ids
  end

  def test_it_finds_by_id
    assert_equal 12334135, mr.find_by_id(12334135).id
  end

  def test_it_finds_by_name
    assert_equal "LolaMarleys", mr.find_by_name("LolaMarleys").name
  end

  def test_it_finds_all_by_name
    assert_equal ["LolaMarleys","GoldenRayPress"], all_names
  end

  private

  def all_names
    all_names = mr.find_all_by_name.map do |merchant|
      merchant.name
    end
  end

  def all_ids
    all_ids = mr.all.map do |merchant|
      merchant.id
    end
  end

end
