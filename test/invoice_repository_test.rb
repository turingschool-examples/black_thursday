require './test/minitest_helper'
require './lib/invoice_repository'
require './lib/invoice'
require './lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
    :merchants     => './test/fixtures/merchants_fixtures.csv',
    :items         => './test/fixtures/items_fixtures.csv',
    :invoices      => './test/fixtures/invoices_fixtures.csv'
                              })
    @invoices_r = se.invoices
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoices_r
  end

  def test_all_returns_an_array_of_all_invoices
    assert_equal 14, @invoices_r.all.count
  end

  def test_it_can_find_by_id
    result = @invoices_r.find_by_id(1)
    assert_equal 1, result.id
  end

  def test_it_can_find_all_by_cusomter_id
    result = @invoices_r.find_all_by_customer_id(2)
    require 'pry'; binding.pry
    assert_equal [], result.customer_id
  end
end
