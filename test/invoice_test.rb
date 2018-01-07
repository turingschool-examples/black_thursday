require_relative 'test_helper'
require_relative '../lib/invoice'


class InvoicesTest < Minitest::Test

  def test_it_exists
    skip
    invoice = Invoice.new

    assert_instance_of Invoice, invoice
  end

end
