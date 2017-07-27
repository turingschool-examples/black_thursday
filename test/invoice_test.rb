gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test

  def test_invoice_exists
    invoice = Invoice.new({:id => 17, :customer_id => 5, :merchant_id => 12334912,
                           :status => "pending", :created_at => "2005-06-03",
                           :updated_at => "2015-07-01"}, self)

    assert_instance_of Invoice, invoice
  end

end
