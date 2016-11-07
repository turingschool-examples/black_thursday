require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repo'

class MerchantTest < Minitest::Test
  attr_reader :data, 
              :repo

  def setup
    @data = {:id => 263567474,
             :name => "Minty Green Knit Crochet Infinity Scarf"
             }
    @repo = Minitest::Mock.new
  end

  def test_it_exists
    assert Merchant.new(data, repo)
  end

  def test_it_has_a_class
    m = Merchant.new(data, repo)
    assert_equal Merchant, m.class
  end

  def test_it_has_an_id
    m = Merchant.new(data, repo)
    assert_equal 263567474, m.id
  end

  def test_it_has_a_name
    m = Merchant.new(data, repo)
    assert_equal "Minty Green Knit Crochet Infinity Scarf", m.name
  end

end
