require_relative 'test_helper'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'pry'

class InvoiceTest < Minitest::Test

  def test_it_exits
    i = Invoice.new({id: 6,
                     customer_id: 7,
                     merchant_id: 8,
                     status: 'pending',
                     created_at: '2009-02-07',
                     updated_at: '2014-03-15'},
                    'parent')
  end


end
