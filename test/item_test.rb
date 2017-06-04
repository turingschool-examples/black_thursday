require_relative 'test_helper'
require_relative '../lib/item'
require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'

class ItemTest < Minitest::Test
  attr_reader :item

  def setup
    # @se = SalesEngine.from_csv({
    #               :items     => "./test/data/items_truncated.csv",
    #               :merchants => "./test/data/merchants_truncated.csv"
    #             })
    #
    # @item_repo = ItemRepository.new({
    #               :items     => "./test/data/items_truncated.csv",
    #               :merchants => "./test/data/merchants_truncated.csv"
    #             }, self)
    #
    # @merchant_repo = MerchantRepository.new({
    #               :items     => "./data/items.csv",
    #               :merchants => "./data/merchants.csv"
    #               })
    #
    # @merchant = Merchant.new({:id => 263395237, :name => "Turing School"})

    @item = Item.new({
                      :name        => "Pencil",
                      :description => "You can use it to write things",
                      :unit_price  => BigDecimal.new(10.99,4),
                      :created_at  => Time.now,
                      :updated_at  => Time.now,
                      :merchant_id    => 12334105
                    }, self)
  end

  def test_it_starts_an_item_instance
    assert_instance_of Item, @item
  end

  def test_attr_reader_works
    assert_equal "Pencil", @item.name
  end

  def test_attr_reader_works_for_other_attributes
    assert_equal 0.1099E2, @item.unit_price
  end

  def test_instance_created_at_works
    actual = @item.created_at.class
    expected = Time

    assert_equal expected, actual
  end

  def test_it_returns_the_unit_price_to_dollars
    assert_equal "10.99", @item.unit_price_to_dollars
  end

  # def test_merchant_method_can_be_called
  #   item = @se.items.find_by_id(263395237)
  #   actual = item.merchant
  #   expected = "#<Merchant:0x007f827207e738>"
  #
  #   assert_equal expected, actual
  # end
end
