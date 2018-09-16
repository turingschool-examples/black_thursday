require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'time'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'

class InvoiceTest<Minitest::Test

  def test_it_exists
    @invoice = Invoice.new({:id => 1,
                            :customer_id => 1,
                            :merchant_id => 12335938,
                            :status => "pending",
                            :created_at => 2009-02-07,
                            :updated_at => 2014-03-15}
                          )

  end

end
