require './test/test_helper'

class InvoiceRepositoryTest < Minitest::Test

  def setup 
    @se = SalesEngine.from_csv({
      :items => "./fixtures/items_small_list.csv",
      :invoices => "./fixtures/invoices_small_list.csv",
      :merchants => "./fixtures/merchant_small_list.csv",
      :invoice_items => "./fixtures/invoice_item_small_list.csv",
      :transactions => "./fixtures/transactions_small_list.csv",
      :customers => "./fixtures/customers_small_list.csv"
    })
    @ir = @se.invoices
  end

  def test_repository_stored_as_array
    assert_equal Array, @ir.all.class
  end

  def test_each_item_stores_an_item_object
    assert_equal Invoice, @ir.all[0].class
  end

  def test_it_knows_parent
    assert_equal SalesEngine, @ir.parent.class
  end

  def test_find_by_id_returns_expected_invoice
    assert_equal :pending, @ir.find_by_id(1).status
    assert_equal :shipped, @ir.find_by_id(3).status
  end

  def test_find_all_by_customer_id_returns_expected_invoices
    assert_equal 7, @ir.find_all_by_customer_id(1).size
  end

  def test_find_all_by_merchant_id_returns_expected_array
    assert_equal Array, @ir.find_all_by_merchant_id(12334185).class
    assert_equal 1, @ir.find_all_by_merchant_id(12335938).size
  end

  def test_find_all_by_status_returns_expected_array
    assert_equal Array, @ir.find_all_by_status(:pending).class
    assert_equal 5, @ir.find_all_by_status(:pending).size
  end

  def test_manual_inspect
    assert_equal "#<InvoiceRepository 7 rows>", @ir.inspect
  end

end