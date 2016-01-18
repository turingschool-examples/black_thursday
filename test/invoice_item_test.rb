require_relative '../lib/invoice_item'
require_relative 'spec_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'


class InvoiceItemTest < Minitest::Test

  def test_class_exist
    assert InvoiceItem
  end



end
