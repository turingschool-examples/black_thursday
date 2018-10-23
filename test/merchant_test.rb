require './lib/merchant'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class MerchantTest < Minitest::Test
  def test_it_exists
    m1 = Merchant.new({:id => 5, :name => "Turing School"})

    assert_instance_of Merchant, m1
  end

  def test_it_has_id
    # skip
    m1 = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal 5, m1.id
  end

  def test_it_has_a_name
    # skip
    m1 = Merchant.new({:id => 5, :name => "Turing School"})
    assert_equal "Turing School", m1.name
  end

  def test_collection_of_merchants
    m1 = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal m1.array_of_hashes, m1.collection_of_merchants
    binding.pry
  end

  def test_merchants_collection_class_method

  end

end
