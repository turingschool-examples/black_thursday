require_relative 'test_helper'

class InvoiceTest < Minitest::Test
    
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

  def test_it_knows_id
    assert_equal 1, @ir.all[0].id
    assert_equal 4, @ir.all[3].id
  end

  def test_it_knows_customer_id
    assert_equal 1, @ir.all[0].customer_id
    assert_equal 1, @ir.all[3].customer_id
  end

  def test_it_knows_merchant_id
    assert_equal 12335938, @ir.all[0].merchant_id
    assert_equal 12334269, @ir.all[3].merchant_id
  end

  def test_ids_have_correct_format
    assert_equal Fixnum, @ir.all[0].customer_id.class
    assert_equal Fixnum, @ir.all[0].merchant_id.class
    assert_equal Fixnum, @ir.all[0].id.class
  end

  def test_it_knows_status
    assert_equal :pending, @ir.all[0].status
    assert_equal :pending, @ir.all[3].status
  end

  def test_status_is_a_symbol
    assert_equal Symbol, @ir.all[0].status.class
  end

  def test_it_determines_time
    assert_equal "2009-02-07 00:00:00 -0700", @ir.all[0].created_at.to_s
    assert_equal "2014-03-15 00:00:00 -0600", @ir.all[0].updated_at.to_s
  end

  def test_it_knows_merchant
    assert_equal "TeeTeeTieDye", @ir.all[3].merchant.name
  end

  def test_it_knows_parent
    assert_equal InvoiceRepository, @ir.all[0].invoice_parent.class
  end

  def test_it_knows_if_is_paid
    assert @ir.all[1].is_paid_in_full?
    refute @ir.all[0].is_paid_in_full?
  end

  def test_it_can_find_items_for_an_invoice
    invoice = @ir.find_by_id(2)

    assert_equal Array, invoice.items.class
    # binding.pry
    assert_equal Item, invoice.items[0].class
  end

  # def test_it_can_find_transactions_from_invoice
  #   invoice = @ir.find_by_id(2)
    
  #   invoice.transactions # => [transaction, transaction]
  #   invoice.customer # => customer
  #   end
end