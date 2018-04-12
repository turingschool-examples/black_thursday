require_relative 'test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  attr_reader :m

  def setup
    @m = Merchant.new({ :id => 5,
                        :name => 'Turing School',
                        :created_at => "2018-04-10",
                        :updated_at => "2018-04-10"
                        }, self)
  end

  def test_it_exists
    assert_instance_of Merchant, m
  end

  def test_it_has_an_id
    assert_equal 5, m.id
  end

  def test_it_has_a_name
    assert_equal "Turing School", m.name
  end

  def test_it_has_created_at
    assert_equal "2018-04-10", m.created_at
  end

  def test_it_has_updated_at
    assert_equal "2018-04-10", m.updated_at
  end
end
