
require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

class MerchantTest < Minitest::Test

  def setup
    @time = Time.now
    @merch = Merchant.new({
      :id   => 3,
      :name => "Bill's Pencil Company"
      })
  end

  def test_it_exists
    assert_instance_of Merchant, @merch
  end

  def test_it_has_attributes
    assert_equal 3, @merch.id
    assert_equal "Bill's Pencil Company", @merch.name
  end

  def test_it_returns_an_array_of_invoices
    se = SalesEngine.from_csv({
                              :items      => './data/items.csv',
                              :merchants  => './data/merchants.csv',
                              :invoices => "./data/invoices.csv"
                              })
    invoice = se.invoices.find_by_id(170)
    merchant = se.merchants.find_by_id(12334135)
    invoices = merchant.invoices
    assert_instance_of Array, invoices
    assert_instance_of Invoice, invoices[0]
    assert invoices.include?(invoice)
  end
end
