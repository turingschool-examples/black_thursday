require_relative './data_object'

class Merchant < DataObject
  def initialize(attributes)
    @editable = [:name]
    super(attributes)
  end
end
