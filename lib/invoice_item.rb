require_relative 'element'

# This class defines InvoiceItems
class InvoiceItem
  include Element

  def initialize(attributes, engine = nil)
    @attributes = attributes
    @engine = engine
  end
end
