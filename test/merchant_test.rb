require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'
require './lib/merchant_repo'

class MerchantTest < Minitest::Test
  attr_reader :data, 
              :repo

  def def setup
    @data = {:id => "263567474",
             :name => "Minty Green Knit Crochet Infinity Scarf",
             :created_at => "2016-01-11 20:59:20 UTC",
             :updated_at => "2009-12-09 12:08:04 UTC"}
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
    assert_equal "263567474", m.id
  end

  def test_it_has_a_name
    m = Merchant.new(data, repo)
    assert_equal "Minty Green Knit Crochet Infinity Scarf", m.name
  end

  def test_it_displays_when_it_was_created
    m = Merchant.new(data, repo)
    assert_equal "2016-01-11", m.created_at
  end

  def test_it_displays_when_it_was_updated
    m = Merchant.new(data, repo)
    assert_equal "2009-12-09", m.updated_at
  end



end
