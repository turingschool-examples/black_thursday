require './test/test_helper'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    @ii = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
      })
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @ii
  end

  def test_it_has_id
    assert_equal 6, @ii.id
  end


end
