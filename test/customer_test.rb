require_relative './test_helper'
require 'time'

class CustomerTest < Minitest::Test

  def setup
    item_path          = "./data/items.csv"
    merchant_path      = "./data/merchants.csv"
    invoice_path       = "./data/invoices.csv"
    invoice_item_path  = "./data/invoice_items.csv"
    customer_path      = "./data/customers.csv"

    arguments = {
                  :items     => item_path,
                  :merchants => merchant_path,
                  :invoices  => invoice_path,
                  :invoice_items => invoice_item_path,
                  :customers => customer_path
                }
    @engine = SalesEngine.from_csv(arguments)
    @customer = @engine.customers.find_by_id(500)
 #  let(:customer) { engine.customers.find_by_id(500) }
  end

  def test_id_returns_the_id
    assert_equal 500, @customer.id
    assert_equal Fixnum, @customer.id.class
  end

  def test_first_name_returns_the_first_name
    assert_equal "Hailey", @customer.first_name
    assert_equal String, @customer.first_name.class
  end

  def test_last_name_returns_the_last_name
    assert_equal "Veum", @customer.last_name
     assert_equal String, @customer.last_name.class
  end

#     expect(customer.last_name).to eq "Veum"
#     expect(customer.last_name.class).to eq String
#   end
#
#   it "#created_at returns a Time instance for the date the invoice item was created" do
#     expect(customer.created_at).to eq Time.parse("2012-03-27 14:56:08 UTC")
#     expect(customer.created_at.class).to eq Time
#   end
#
#   it "#updated_at returns a Time instance for the date the invoice item was last updated" do
#     expect(customer.updated_at).to eq Time.parse("2012-03-27 14:56:08 UTC")
#     expect(customer.updated_at.class).to eq Time
#   end
end
