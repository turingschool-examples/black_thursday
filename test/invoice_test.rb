require './test/test_helper.rb'
require './lib/invoice'

class InvoiceTest < Minitest::Test

  def setup
    @invoices = {
        :id => 1,
        :customer_id  => 1,
        :merchant_id  => 12335938,
        :status       => "pending",
        :created_at   => Time.now,
        :updated_at   => Time.now
        }
        @parent = ""
  end

  def test_it_exists
    assert_instance_of Invoice, Invoice.new(@invoices, @parent)
  end

  def test_it_names
    skip
    invoice = Invoice.new(@invoices, @parent)
    assert_equal "Pencil", invoice.name
  end

  def test_it_describes
    skip
    invoice = Invoice.new(@invoices, @parent)
    assert_equal "You can use it to write things", invoice.description
  end

  def test_it_creates_at_time
    skip
    invoice = Invoice.new(@invoices, @parent)
    time = Time.now
    assert_equal time, invoice.created_at
  end

  def test_it_updates_at_time
    skip
    invoice = Invoice.new(@invoices, @parent)
    time = Time.now
    assert_equal Time, invoice.updated_at
  end

  def test_it_can_find_merchant
    skip
    assert_instance_of Merchant
  end

end
