require './test/minitest_helper'

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


end
