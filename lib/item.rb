require_relative './data_object'

class Item < DataObject
  include MerchantID, Description, UnitPrice, UnitPriceToDollars,
          CreatedAt, UpdatedAt

  def initialize(attributes)
    @editable = [:name, :description, :unit_price]
    super(attributes)
  end
end
