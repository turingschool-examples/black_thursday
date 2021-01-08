require './test/test_helper'

class InvoiceTest < Minitest::Test

  def setup
    @repository = mock
    @data = Invoice.new({
      :id => 1,
      :customer_id => 1,
      :merchant_id => "12335938",
      :status => "pending",
      :created_at => "2016-01-11 11:51:37 UTC",
      :updated_at => Time.now}, @repository)
  end
  def test_it_exists
      assert_instance_of Invoice, @data
    end

  def test_it_has_attributes
    assert_equal 1, @data.id
    assert_equal 1, @data.customer_id
    assert_equal "12335938", @data.merchant_id
    expected = Time.parse("2016-01-11 11:51:37 UTC")
    assert_equal expected, @data.created_at
    assert_instance_of Time, @data.updated_at
  end

end
