require_relative './data_object'

class Invoice < DataObject
  include MerchantID, CustomerID, Status, UnitPrice, UnitPriceToDollars,
          CreatedAt, UpdatedAt

  def initialize(attributes)
    @editable = [:status]
    super(attributes)
  end
end
