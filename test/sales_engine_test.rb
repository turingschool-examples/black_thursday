require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_from_csv_creates_sales_engine_objects
    sales_engine = SalesEngine.from_csv({
                                          :items     => './data/items.csv',
                                          :merchants => './data/merchants.csv',
                                          :invoices  => './data/invoices.csv',
                                          :customers => './data/customers.csv'
                                        })

    assert_instance_of SalesEngine, sales_engine
  end

  def test_it_exists
    sales_engine = SalesEngine.from_csv({
                                          :items     => './data/items.csv',
                                          :merchants => './data/merchants.csv',
                                          :invoices  => './data/invoices.csv',
                                          :customers => './data/customers.csv'
                                        })
    assert_instance_of SalesEngine, sales_engine
  end

  def test_it_creates_instances_of_objects
    sales_engine = SalesEngine.from_csv({
                                          :items     => './data/items.csv',
                                          :merchants => './data/merchants.csv',
                                          :invoices  => './data/invoices.csv',
                                          :customers => './data/customers.csv'
                                        })

    assert_instance_of ItemRepository, sales_engine.items
    assert_instance_of MerchantRepository, sales_engine.merchants
    assert_instance_of InvoiceRepository, sales_engine.invoices
    assert_instance_of SalesAnalyst, sales_engine.analyst
  end

  def test_it_can_find_all_merchants
    sales_engine = SalesEngine.from_csv({
                                          :items     => './data/items.csv',
                                          :merchants => './data/merchants.csv',
                                          :invoices  => './data/invoices.csv',
                                          :customers => './data/customers.csv'
                                        })

      assert_equal 475, sales_engine.all_merchants.count
  end

    def test_it_can_find_all_items_by_merchant_id
      sales_engine = SalesEngine.from_csv({
                                            :items     => './data/items.csv',
                                            :merchants => './data/merchants.csv',
                                            :invoices  => './data/invoices.csv',
                                            :customers => './data/customers.csv'
                                          })

        assert_equal 1, sales_engine.find_all_items_by_merchant_id(12334112).count
    end

    def test_it_can_find_all_items
      sales_engine = SalesEngine.from_csv({
                                            :items     => './data/items.csv',
                                            :merchants => './data/merchants.csv',
                                            :invoices  => './data/invoices.csv',
                                            :customers => './data/customers.csv'
                                          })

        assert_equal 1367, sales_engine.all_items.count
    end

    def test_it_can_find_all_invoices
      sales_engine = SalesEngine.from_csv({
                                            :items     => './data/items.csv',
                                            :merchants => './data/merchants.csv',
                                            :invoices  => './data/invoices.csv',
                                            :customers => './data/customers.csv'
                                          })

        assert_equal 4985, sales_engine.all_invoices.count
    end

    def test_it_can_find_all_invoices_by_merchant_id
      sales_engine = SalesEngine.from_csv({
                                            :items     => './data/items.csv',
                                            :merchants => './data/merchants.csv',
                                            :invoices  => './data/invoices.csv',
                                            :customers => './data/customers.csv'
                                          })

        assert_equal 7, sales_engine.find_all_invoices_by_merchant_id(12334112).count
    end
end
