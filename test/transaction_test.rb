require './test/test_helper'

class TransactionTest < Minitest::Test
  attr_reader :t,
              :parent
  def setup
    @parent = SalesEngine.from_csv({:transactions => './test/fixtures/transaction_three.csv'})

    @t = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => "2012-02-26 20:56:56 UTC",
      :updated_at => "2013-02-26 20:56:56 UTC"
    }, parent)
  end

  def test_it_exists
    assert_instance_of Transaction, t
  end

  def test_it_knows_its_id
    assert_equal 6, t.id  
  end

  def test_it_knows_its_invoice_id
    assert_equal 8, t.invoice_id
  end

  def test_it_knows_credit_card_number
    assert_equal 4242424242424242, t.credit_card_number
  end

  def test_it_knows_credit_card_expiration_date
    assert_equal "0220", t.credit_card_expiration_date
  end

  def test_it_knows_result
    assert_equal "success", t.result
  end

  def test_it_knows_created_at
    assert_instance_of Time, t.created_at
    assert_equal "2012-02-26 20:56:56 UTC", t.created_at.to_s
  end

  def test_it_knows_updated_at
    assert_instance_of Time, t.updated_at
    assert_equal "2013-02-26 20:56:56 UTC", t.updated_at.to_s
  end

  def test_parent_is_instance_of_transaction_repository
    se = SalesEngine.from_csv({:transactions => './test/fixtures/transaction_three.csv'})
    tr = se.transactions
    t = tr.all.first

    assert_instance_of TransactionRepository, t.parent
  end

  def test_invoice_method
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_100.csv',
                               :items => './test/fixtures/items_100.csv',
                               :invoices => './data/invoices.csv',
                               :invoice_items => './test/fixtures/invoice_items_100.csv',
                               :transactions => './test/fixtures/transaction_100.csv',
                               :customers => './test/fixtures/customer_100.csv'})
    tr = se.transactions
    t = tr.all.first
  
    assert_instance_of Invoice, t.invoice
    assert_equal 2179, t.invoice.id
  end

end