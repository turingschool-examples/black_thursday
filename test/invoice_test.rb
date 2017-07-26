require_relative 'test_helper'
require './lib/invoice'
require 'pry'

class InventoryTest < Minitest::Test
  def test_it_exist
    invoice = Invoice.new
    assert_instance_of Invoice, invoice
  end
end
