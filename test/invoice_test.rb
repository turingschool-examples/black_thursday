require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repo'
require 'bigdecimal'

class InvoiceTest < Minitest::Test
  attr_reader :data,
              :repo
  def setup
    @data = {:id => 292,
             :customer_id => 57,
             :merchant_id => 12334713,
             :status => "shipped",
             :created_at => "2004-07-23",
             :updated_at => "2007-11-20"}
    @repo = Minitest::Mock.new
  end

  def test_it_exists
    assert Invoice.new(data, repo)
  end
  def test_it_has_a_class
    i = Invoice.new(data, repo)
    assert_equal Invoice, i.class
  end
  def test_it_has_an_id
    i = Invoice.new(data, repo)
    assert_equal 292, i.id
  end

  def test_it_has_a_merchant_id
    i = Invoice.new(data, repo)
    assert_equal 12334713, i.merchant_id
  end

  def test_it_displays_when_it_was_created
    i = Invoice.new(data, repo)
    assert_equal "2004-07-23 00:00:00 -0600", i.created_at.to_s
  end

  def test_it_displays_when_it_was_updated
    i = Invoice.new(data, repo)
    assert_equal "2007-11-20 00:00:00 -0700", i.updated_at.to_s
  end

end