require_relative 'mock_item'

# Mocks the sales engine for testing
class MockSalesEngine
  attr_reader :items

  def initialize
    @items = []
    add_items
  end

  def add_items
    2.times { @items.push(MockItem.new) }
  end

  def find_merchant_items(id)
    @items
  end
end
