require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
  attr_reader :i

  def setup
    @i = Invoice.new({
      :id          => "263410303",
      :customer_id => "12233444",
      :merchant_id => "1234566",
      :status      => "pending",
      :created_at  => "2016-04-19 09:04:25 -0600",
      :updated_at  => "2016-04-19 09:04:25 -0600"
    })
  end

  def test_it_returns_status_as_a_symbol
    assert_equal :pending, i.status
  end 

end
