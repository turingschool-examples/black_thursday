require './test/test_helper'

class InvoiceTest < Minitest::Test
  attr_reader :invoice
  def setup
    @invoice = Invoice.new({
      :id          => "2",
      :customer_id => "1", 
      :merchant_id => "12334753",
      :status      => "shipped", 
      :created_at  => "2012-11-23", 
      :updated_at  => "2013-04-14"
    })
  end

  def test_it_exits
    assert_instance_of Invoice, invoice
  end

  def test_has_id
    assert_equal 2, invoice.id
  end

  def test_has_customer_id
    assert_equal 1, invoice.customer_id
  end

  def test_has_merchant_id
    assert_equal 12334753, invoice.merchant_id
  end

  def test_has_status
    assert_equal :shipped, invoice.status
  end

  def test_has_created_at
    assert_instance_of Time, invoice.created_at 
  end 
  
  def test_has_update_at
    assert_instance_of Time, invoice.updated_at 
  end

  def test_merchant
    binding.pry
    assert_equal 234234, invoice.merchant
  end

  def test_items
  end

  def test_transactions
  end

  def test_customer
  end
end