require 'bigdecimal'
require './test/test_helper'

class TransactionTest < Minitest::Test

  def setup
    @repository = mock
    @data = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => "2016-01-11 11:51:37 UTC",
      :updated_at => Time.now}, @repository)
  end
  def test_it_exists
      assert_instance_of Transaction, @data
    end

  def test_it_has_attributes
    assert_equal 6, @data.id
    assert_equal 8, @data.invoice_id
    assert_equal "4242424242424242", @data.credit_card_number
    assert_equal "0220", @data.credit_card_expiration_date
    assert_equal "success", @data.result
    expected = Time.parse("2016-01-11 11:51:37 UTC")
    assert_equal expected, @data.created_at
    assert_instance_of Time, @data.updated_at
  end

end
