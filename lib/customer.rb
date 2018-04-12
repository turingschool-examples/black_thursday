require_relative 'element'

# This class defines InvoiceItems
class Customer
  include Element

  def initialize(attributes, engine = nil)
    @attributes = attributes
    @engine = engine
  end
end
