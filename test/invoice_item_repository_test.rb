require './test/helper'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
    :merchants     => './test/fixtures/merchants_fixtures.csv',
    :items         => './test/fixtures/items_fixtures.csv',
    :invoices      => './test/fixtures/invoices_fixtures.csv',
    :invoice_items => './test/fixtures/invoice_items_fixtures.csv'
                              })
    @i_i_r = se.invoice_items
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository,@i_i_r
  end
end
