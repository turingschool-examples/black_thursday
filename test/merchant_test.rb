require_relative 'test_helper'
require_relative "../lib/merchant"


class MerchantTest < Minitest::Test

  def setup
    @se = SalesEngine.new({
      :items         => "./test/fixtures/items_sample.csv",
      :merchants     => "./test/fixtures/merchants_sample.csv",
      :invoices      => "./test/fixtures/invoices_sample.csv",
      :customers     => "./test/fixtures/customers_sample.csv",
      :invoice_items => "./test/fixtures/invoice_items_sample.csv"
      })
    @merchant = @se.merchants.find_by_id(12334183)
  end

  def test_it_exists
    assert_instance_of Merchant, @merchant
  end

  def test_it_has_an_id
    assert_equal 12334183, @merchant.id
  end

  def test_it_has_a_name
    assert_equal "handicraftcallery", @merchant.name
  end

  def test_it_has_a_created_at
    assert_equal Time.parse("2002-03-30"), @merchant.created_at
  end

  def test_it_grab_items
    assert_equal 1, @merchant.items.count
    assert @merchant.items.all? { |item| item.class == Item }
  end

  def test_it_grabs_all_invoices
    assert_equal 1, @merchant.invoices.count
    assert @merchant.invoices.all? { |invoice| invoice.class == Invoice }
  end

  def test_it_grabs_all_customers
    assert_equal 1, @merchant.customers.count
    assert_equal 963, @merchant.customers.first.id
    assert @merchant.customers.all? { |customer| customer.class == Customer }
  end

  def test_it_returns_revenue # NEEDS TO BE LINKED SOMETHING IS WRONG!!!!
    assert_equal 234, @merchant.revenue
  end

end
