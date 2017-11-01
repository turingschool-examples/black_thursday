
require_relative 'test_helper'
require './lib/sales_engine'
require './lib/item_repository'


class ItemRepositoryTest < MiniTest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({:items => './test/fixtures/items_fixture.csv', :merchants => './test/fixtures/merchants.csv', :invoices => './test/fixtures/invoice.csv'})
    @invoice_repository = @sales_engine.invoice_repository
  end

  def test_that_invoices_are_created
    assert_equal 19, @invoice_repository.count
    assert_equal 1, @invoice_repository.invoices[0].id
    assert_equal 2, @invoice_repository.invoices[1].id
  end

  def test_that_it_finds_all_invoices
    assert_equal @invoice_repository.invoices, @invoice_repository.all
  end

  def test_that_it_finds_invoices_by_id
    invoice1 = @invoice_repository.invoices[0]

    assert_equal merchant1, @invoice_repository.find_by_id(1)
  end

end
