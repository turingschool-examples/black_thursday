require_relative 'element'

# This class defines invoiceItems
class InvoiceItem
  include Element

  def initialize(attributes, engine = nil)
    @attributes = attributes
    @engine = engine
  end
end
