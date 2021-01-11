require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'


class InvoiceTest < MiniTest::Test

  def setup
    @repo = "repo"
    @i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      }, @repo)
  end

  def test_it_exists

    assert_instance_of Invoice, @i
  end

  def test_it_has_readable_attributes
    assert_equal 6, @i.id
    assert_equal 7, @i.customer_id
    assert_equal 8, @i.merchant_id
    assert_equal "pending", @i.status
    assert_equal Time.now.to_s, @i.created_at.to_s
    assert_equal Time.now.to_s, @i.updated_at.to_s
  end

  def test_created_day
    expected = Time.new(2021, 1, 11)
    expected1 = Time.new(2021, 1, 12)
    expected2 = Time.new(2021, 1, 13)
    expected3 = Time.new(2021, 1, 10)
    i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => expected3,
      :updated_at  => Time.now,
      }, @repo)

    # assert_equal :monday, expected
    # assert_equal :tuesday, expected1
    # assert_equal :wednesday, expected2
    assert_equal :sunday, i.created_day
  end

end
