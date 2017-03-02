require './test/test_helper'

class MerchantTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_three.csv'})
    mr = se.merchants
    m = mr.all
    
    assert_instance_of Merchant, m.first
  end

  def test_id_method_returns_id
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_three.csv'})
    mr = se.merchants
    m = mr.all
    
    assert_equal 12334105, m.first.id
  end

  def test_name_method_returns_name
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_three.csv'})
    mr = se.merchants
    m = mr.all
    
    assert_equal "Shopin1901", m.first.name
  end

  def test_parent_is_instance_of_merchant_repository
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_three.csv'})
    mr = se.merchants
    m = mr.all

    assert_instance_of MerchantRepository, m.first.parent
  end

  def test_merchant_can_find_items
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchant_matches.csv', :items => './test/fixtures/items_same_merchant_id.csv'})
    merchant = se.merchants.find_by_id(12334185)   
    
    assert_equal Array, merchant.items.class
    assert_equal 3, merchant.items.length
    assert_equal Item, merchant.items.first.class
  end

  def test_merchant_can_find_invoices
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchant_matches.csv',
                               :items => './test/fixtures/items_same_merchant_id.csv',
                               :invoices => './test/fixtures/invoices_three.csv'})
    mr = se.merchants
    merchant = mr.find_by_id(12335938)

    assert_instance_of Array, merchant.invoices
    assert_instance_of Invoice, merchant.invoices.first
    assert_equal 2, merchant.invoices.length
  end

  def test_it_can_find_customer
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_100.csv',
                               :items => './test/fixtures/items_100.csv',
                               :invoices => './data/invoices.csv',
                               :invoice_items => './test/fixtures/invoice_items_100.csv',
                               :transactions => './test/fixtures/transaction_100.csv',
                               :customers => './data/customers.csv'})
    mr = se.merchants
    merchant = mr.find_by_id(12334194)

    assert_instance_of Array, merchant.customers
    assert_instance_of Customer, merchant.customers.first
    assert_equal 12, merchant.customers.length
  end

  def test_created_at
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_three.csv'})
    mr = se.merchants
    m = mr.all
    
    assert_equal "2010-12-10 00:00:00 -0700", m.first.created_at.to_s
  end

  def test_month_created
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_three.csv'})
    mr = se.merchants
    m = mr.all
      
    assert_equal "December", m.first.month_created
  end
end


