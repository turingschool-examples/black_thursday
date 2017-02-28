require './test/test_helper'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def setup
    @invoice_item = {
      :id         => 6,
      :item_id    => 7,
      :invoice_id => 8,
      :quantity   => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    }
  end

  def test_it_has_an_id
    assert_equal 602397854, @merchant.id
  end

  def test_it_has_a_name
    assert_equal "Burger King", @merchant.name
  end

  def test_it_has_a_created_at
    assert_equal Time, @merchant.created_at.class
  end

  def test_it_has_a_updated_at
    assert_equal Time, @merchant.updated_at.class
  end
end
