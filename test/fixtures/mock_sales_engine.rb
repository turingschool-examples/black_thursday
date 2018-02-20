require_relative 'mock_item'
require_relative 'mock_merchant'

# Mocks the sales engine for testing
class MockSalesEngine
  attr_reader :items

  def initialize
    @items = []
    add_items
    @merchant = MockMerchant.new
  end

  def add_items
    2.times { @items.push(MockItem.new) }
  end

  def find_merchant_items(_id)
    @items
  end

  def find_item_merchant(_id)
    @merchant
  end
end
