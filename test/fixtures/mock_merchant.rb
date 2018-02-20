# Mock merchant for testing
class MockMerchant
  attr_reader :id,
              :name,
              :parent

  def initialize
    @id   = 'id'
    @name = 'name'
    @parent = 'parent'
  end
end
