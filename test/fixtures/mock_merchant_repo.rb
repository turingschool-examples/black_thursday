require_relative 'mock_item'

# Mocks the merchant repository class for testing
class MockMerchantRepo
  def initialize
    @items = []
    add_items
  end

  def add_items
    2.times { @items.push(MockItem.new) }
  end

  def items(id)
    @items
  end
end
