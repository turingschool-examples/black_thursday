require './test/test_helper'

class MerchantTest < Minitest::Test
  def setup
    item_path = "./data/items.csv"
    merchant_path = "./data/merchants.csv"
    invoice_path = "./data/invoices.csv"
    arguments = {
                  :items     => item_path,
                  :merchants => merchant_path,
                  :invoices  => invoice_path
                }
    @se = SalesEngine.from_csv(arguments)
    @mr = @se.merchants
    @merchant = @mr.all.first
  end

  def test_it_exists
    assert_instance_of Merchant, @merchant
  end

  def test_it_has_attributes
    assert_equal 12334105, @merchant.id
    assert_equal "Shopin1901", @merchant.name
  end
end
