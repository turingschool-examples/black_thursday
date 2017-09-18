require_relative 'test_helper'
require_relative  '../lib/invoice_repository'
require_relative '../lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
      :invoices => "./test/fixtures/invoices_fixture.csv"
    })
    vr = se.invoices
  end

  def test_invoice_repo_returns_array_of_all_invoices
    vr = setup

    assert_equal 46, vr.all.length
  end

  def test_it_finds_invoice_by_id
    vr = setup

    assert_instance_of Invoice, vr.find_by_id(74)
  end

  def test_it_finds_all_by_customer_id
    vr = setup

    assert_equal 1, vr.find_all_by_customer_id(14).count
    assert_equal 2, vr.find_all_by_customer_id(500).count
  end

  def test_it_finds_all_by_merchant_id
    vr = setup

    assert_equal 3, vr.find_all_by_merchant_id(12334105).count
    assert_equal 6, vr.find_all_by_merchant_id(12334123).length
  end

  def test_it_finds_all_by_status
    vr =setup

    assert_equal 9, vr.find_all_by_status(:returned).count
    assert_equal 20, vr.find_all_by_status(:shipped).count
    assert_equal 17, vr.find_all_by_status(:pending).count
  end

end
