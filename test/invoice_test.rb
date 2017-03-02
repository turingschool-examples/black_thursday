require './test/test_helper.rb'

class InvoiceTest < Minitest::Test
  attr_reader :invoice

  def setup
    @invoice = Invoice.new({
      :id           => 1,
      :customer_id  => 1,
      :merchant_id  => 12335938,
      :status       => "pending",
      :created_at   => "2012-03-27 14:54:09 UTC",
      :updated_at   => "2012-03-27 14:54:09 UTC"},
      parent = ""
    )
  end

  def test_it_exists
    assert_instance_of Invoice, invoice
  end

  def test_the_id
    assert_equal 1, invoice.id
  end

  def test_the_customer_id
    assert_equal 1, invoice.customer_id
  end

  def test_the_merchant_id
    assert_equal 12335938, invoice.merchant_id
  end

  def test_the_status
    assert_equal :pending, invoice.status
  end

  def test_it_creates_at_time
    assert_instance_of Time, invoice.created_at
  end

  def test_it_updates_at_time
    assert_instance_of Time, invoice.updated_at
  end

end
