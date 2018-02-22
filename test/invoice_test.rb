require_relative 'test_helper'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'pry'

# test for invoice class
class InvoiceTest < Minitest::Test
  def setup
    @i = Invoice.new({ id: 6,
                       customer_id: 7,
                       merchant_id: 8,
                       status: 'pending',
                       created_at: '2009-02-07',
                       updated_at: '2014-03-15' },
                     'parent')
  end

  def test_it_exists
    assert_instance_of Invoice, @i
  end

  def test_it_has_attributes
    assert_equal 6, @i.id
    assert_equal 7, @i.customer_id
    assert_equal 8, @i.merchant_id
    assert_equal 'pending', @i.status
    assert_equal Time.parse('2009-02-07'), @i.created_at
    assert_equal Time.parse('2014-03-15'), @i.updated_at
    assert_equal 'parent', @i.parent
  end

end
