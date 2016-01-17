require_relative '../lib/invoice'
require_relative '../lib/sales_engine'
require_relative 'spec_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'


class InvoiceTest < Minitest::Test

  def test_class_exist
    assert Invoice
  end


end
