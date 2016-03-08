require 'pry'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'


class SalesEngineTest < Minitest::Test
  def setup
    @sales_engine = SalesEngine.from_csv({
      :items     => 'data/items.csv',
      :merchants => 'data/merchants.csv',
      :invoices => 'data/invoices.csv',
      :invoice_items => 'test/fake_invoice_items.csv',
      :transactions => 'test/fake_transactions.csv',
      :customers => 'test/fake_customers.csv'
    })
  end

  def test_can_load_file
    file = SalesEngine.load_file('data/items.csv')
    assert file
  end

  def test_items_can_be_loaded_into_repository
    file = SalesEngine.load_file('data/items.csv')
    assert_equal 1367, @sales_engine.items.repository.count
  end

  def test_merchants_can_be_loaded_into_repository
    file = SalesEngine.load_file('data/merchants.csv')
    assert_equal 475, @sales_engine.merchants.repository.count
  end

  def test_from_csv_will_create_Sales_Engine_object_and_add_files_into_repositories
    assert_equal 1367, @sales_engine.items.repository.count
    assert_equal 475, @sales_engine.merchants.repository.count
    mr = @sales_engine.merchants
    ir = @sales_engine.items

    assert_equal 12334112, mr.find_by_name("candIsArt").id
    assert_equal nil, mr.find_by_name("Girls Rule the World Shop")
    assert_equal "Le corps et la chauffeuse", ir.find_by_id(263398179).name
  end

  def test_can_invoice_by_id
    assert_equal 12, @sales_engine.invoices.find_by_id(12).id
  end

end
