require 'test_helper'
require './lib/merchant_repository'
require './lib/merchant'

class MerchantRepositoryTest < Minitest::Test

  def setup
    @mr = MerchantRepository.new
    @mr.create({:id => 5, :name => "Turing School"})
  end
  def test_it_exists

    assert_instance_of MerchantRepository, @mr
  end

  def test_all_returns_array_of_known_merchants

    assert_equal 1, @mr.all.count
  end

  def test_find_by_id

    assert_equal "Turing School", @mr.find_by_id(5).name
  end

  def test_find_by_name

    assert_equal 5, @mr.find_by_name("Turing School").id
  end

  def test_find_all_by_name

    assert_equal 5, @mr.find_all_by_name("Turing School").first.id
  end

  def test_create
    @mr.create({:id => 10, :name => "Asa"})

    assert @mr.all.map(&:id).include?(10)
  end

  def test_update

    assert_equal @mr.all.map(&:name).iclude?("Programming"), @mr.update(5, {:name => "Programming"})
  end

  def test_delete
     @mr.delete(5)

    refute @mr.all.map(&:id).include?(5)
  end
end
