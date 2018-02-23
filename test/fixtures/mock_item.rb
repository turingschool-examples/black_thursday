# Mocks the item class for testing
class MockItem
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize
    @id          = 'id'
    @name        = 'name'
    @description = 'description'
    @unit_price  = 'unit price'
    @merchant_id = 'merchant id'
    @created_at  = 'created at'
    @updated_at  = 'updated at'
  end
end
