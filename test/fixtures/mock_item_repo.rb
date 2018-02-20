require_relative 'mock_merchant'

# Mock Item repository for testing
class MockItemRepo
  def initialize
    @merchant = MockMerchant.new
  end

  def merchant(_id)
    @merchant
  end
end
