require "minitest/autorun"
require "minitest/pride"
require "./lib/invoice_item"
require "simplecov"
require "bigdecimal"

SimpleCov.start

class InvoiceItemTest < Minitest::Test
  attr_reader :ini,
              :parent
  def setup
    @parent = SalesEngine.from_csv({:invoice_items => './test/fixtures/invoice_items_three.csv'})

    @ini = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC",
        }, parent)
  end

  def test_it_exists
    assert_instance_of InvoiceItem, ini  
  end  

  def test_it_knows_its_id
    assert_equal 6, ini.id
  end

  def test_it_knows_its_item_id
    assert_equal 7, ini.item_id
  end

  def test_it_knows_its_invoice_id
    assert_equal 8, ini.invoice_id
  end

  def test_it_knows_its_quantity
    assert_equal 1, ini.quantity
  end

  def test_it_knows_its_unit_price
    assert_instance_of BigDecimal, ini.unit_price
    assert_equal 10.99, ini.unit_price
  end

  def test_it_knows_its_created_at
    assert_instance_of Time, ini.created_at
  end

  def test_it_knows_its_update_at
    assert_instance_of Time, ini.updated_at
  end

  def test_unit_price_to_dollars
    assert_equal 10.99, ini.unit_price_to_dollars
  end

  def test_parent_is_instance_of_invoice_item_repository
    se = SalesEngine.from_csv({:invoice_items => './test/fixtures/invoice_items_three.csv'})
    iir = se.invoice_items
    ini = iir.all.first

    assert_instance_of InvoiceItemRepository, ini.parent
  end
end