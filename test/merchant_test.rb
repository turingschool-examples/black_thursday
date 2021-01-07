require './test/test_helper'

class MerchantTest < Minitest::Test
  def test_it_exists
    @repo = mock
    m = Merchant.new({
                      :id => 5,
                      :name => "Turing School",
                      :created_at => "2008-06-09",
                      :updated_at => Time.now
                      }, @repo)

    assert_instance_of Merchant, m
  end

  def test_it_has_attributes
    m = Merchant.new({
                      :id => 5,
                      :name => "Turing School",
                      :created_at => "2008-06-09",
                      :updated_at => Time.now
                      }, @repo)

    assert_equal 5, m.id
    assert_equal "Turing School", m.name
    actual = Time.parse("2008-06-09")
    assert_equal actual, m.created_at
    assert_instance_of Time, m.updated_at
  end
end
