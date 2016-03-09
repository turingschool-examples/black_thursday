require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

class MerchantTest < Minitest::Test
  def setup
    @sales_engine = SalesEngine.from_csv({
      :items     => 'data/items.csv',
      :merchants => 'data/merchants.csv',
      :invoices => 'data/invoices.csv',
      :invoice_items => 'data/invoice_items.csv',
      :transactions => 'data/transactions.csv',
      :customers => 'data/customers.csv'
    })

    @merchant_one = Merchant.new(@sales_engine,{:id => 12334105,
                                            :name => "Turing School",
                                            :created_at => "2016-02-29",
                                            :updated_at => "2016-03-01" })

    @merchant_two = Merchant.new(@sales_engine,{:id => 12334112,
                                            :name => "Candisart",
                                            :created_at => "2009-05-30",
                                            :updated_at => "2010-08-29" })
  end

  def test_merchant_can_be_instantiated
    m = @merchant_one
    assert m
    assert_equal Merchant, m.class
  end

  def test_merchant_id_can_be_identified
    m = @merchant_one
    assert_equal 12334105, m.id
  end

  def test_merchant_name_can_be_identified
    m = @merchant_one
    assert_equal "Turing School", m.name
  end

  def test_merchant_object_can_be_inspected
    m = @merchant_one
    assert_equal "id: 12334105,\nname: Turing School,\ncreated_at: 2016-02-29,\nupdated_at: 2016-03-01", m.inspect
  end

  def test_customers_can_by_found_by_merchant_id
    m_two = @merchant_two
    assert_equal 51, m_two.customers.first.id
    assert_equal [51, 339, 500, 508, 811, 933, 949], m_two.customers.map { |customer| customer.id }
  end
end
