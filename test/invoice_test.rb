require './test/test_helper'

class InvoiceTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({:invoices => './test/fixtures/invoice_one.csv'})
    inr = se.invoices
    i = inr.all

    assert_instance_of Invoice, i.first
  end

  def test_id_returns_id
    se = SalesEngine.from_csv({:invoices => './test/fixtures/invoice_one.csv'})
    inr = se.invoices
    i = inr.all

    assert_equal 1, i.first.id
  end

  def test_customer_id_returns_customer_id
    se = SalesEngine.from_csv({:invoices => './test/fixtures/invoice_one.csv'})
    inr = se.invoices
    i = inr.all

    assert_equal 1, i.first.customer_id
  end

  def test_merchant_id_returns_merchant_id
    se = SalesEngine.from_csv({:invoices => './test/fixtures/invoice_one.csv'})
    inr = se.invoices
    i = inr.all

    assert_equal 12335938, i.first.merchant_id
  end

  def test_status_returns_status
    se = SalesEngine.from_csv({:invoices => './test/fixtures/invoice_one.csv'})
    inr = se.invoices
    i = inr.all

    assert_equal :pending, i.first.status
  end

  def test_created_at_returns_time_created
    se = SalesEngine.from_csv({:invoices => './test/fixtures/invoice_one.csv'})
    inr = se.invoices
    i = inr.all

    assert_equal '2009-02-07 00:00:00 -0700', i.first.created_at.to_s
    assert_instance_of Time, i.first.created_at
  end

  def test_knows_when_updated
    se = SalesEngine.from_csv({:invoices => './test/fixtures/invoice_one.csv'})
    inr = se.invoices
    i = inr.all

    assert_equal '2014-03-15 00:00:00 -0600', i.first.updated_at.to_s
    assert_instance_of Time, i.first.updated_at
  end

  def test_can_find_merchants
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchant_matches.csv',
                               :items => './test/fixtures/items_same_merchant_id.csv',
                               :invoices => './test/fixtures/invoices_three.csv'})
    inr = se.invoices
    invoice = inr.find_by_id(1)

    assert_instance_of Merchant, invoice.merchant
    assert_equal "IanLudiBoards", invoice.merchant.name
  end

  def test_it_knows_weekday_created_at
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchant_matches.csv',
                               :items => './test/fixtures/items_same_merchant_id.csv',
                               :invoices => './test/fixtures/invoices_three.csv'})
    inr = se.invoices
    invoice = inr.find_by_id(1)

    assert_equal "Saturday", invoice.weekday_created
  end

  def test_it_can_find_items
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_100.csv',
                               :items => './data/items.csv',
                               :invoices => './test/fixtures/invoices_100.csv',
                               :invoice_items => './test/fixtures/invoice_items_100.csv',
                               :transactions => './test/fixtures/transaction_100.csv',
                               :customers => './test/fixtures/customer_100.csv'})
    inr = se.invoices
    invoice = inr.find_by_id(1)

    assert_instance_of Array, invoice.items
    assert_instance_of Item, invoice.items.first
    assert_equal 8, invoice.items.length
  end

  def test_it_can_find_transactions
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_100.csv',
                               :items => './test/fixtures/items_100.csv',
                               :invoices => './test/fixtures/invoices_100.csv',
                               :invoice_items => './test/fixtures/invoice_items_100.csv',
                               :transactions => './data/transactions.csv',
                               :customers => './test/fixtures/customer_100.csv'})
    inr = se.invoices
    invoice = inr.find_by_id(1)

    assert_instance_of Array, invoice.transactions
    assert_instance_of Transaction, invoice.transactions.first
    assert_equal 2, invoice.transactions.length
  end

  def test_it_can_find_customer
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_100.csv',
                               :items => './test/fixtures/items_100.csv',
                               :invoices => './test/fixtures/invoices_100.csv',
                               :invoice_items => './test/fixtures/invoice_items_100.csv',
                               :transactions => './test/fixtures/transaction_100.csv',
                               :customers => './test/fixtures/customer_100.csv'})
    inr = se.invoices
    invoice = inr.find_by_id(1)

    assert_instance_of Customer, invoice.customer
    assert_equal "Joey", invoice.customer.first_name
  end


  def test_paid_in_full
    se = SalesEngine.from_csv({:invoices => './data/invoices.csv',
                               :transactions => './test/fixtures/transaction_100.csv'})                                                   
    inr = se.invoices
    invoice_1 = inr.find_by_id(2179)
    invoice_2 = inr.find_by_id(1752)

    assert invoice_1.is_paid_in_full?
    refute invoice_2.is_paid_in_full?
  end

  def test_invoice_total
    se = SalesEngine.from_csv({:invoices => './test/fixtures/invoices_100.csv',
                               :invoice_items => './data/invoice_items.csv',})
    inr = se.invoices
    invoice = inr.find_by_id(1)

    assert_equal 21067.77, invoice.total.to_f
  end

end
