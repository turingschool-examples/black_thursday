require './test/test_helper.rb'
require './lib/invoice.rb'

class InvoiceTest < Minitest::Test
  def setup
    @i = Invoice.new(
      id: 6,
      customer_id: 7,
      merchant_id: 8,
      status: 'pending',
      created_at: '2018-05-29 20:06:09 -0600',
      updated_at: '2018-05-29 20:06:09 -0600'
    )
  end

  def test_it_exists
    assert_instance_of Invoice, @i
  end

  def test_it_has_attributes
    assert_equal 6, @i.id
    assert_equal 7, @i.customer_id
    assert_equal 8, @i.merchant_id
    assert_equal :pending, @i.status
    assert_equal Time.parse('2018-05-29 20:06:09 -0600'), @i.created_at
    assert_equal Time.parse('2018-05-29 20:06:09 -0600'), @i.updated_at
  end
end
