require_relative 'element'

# This class defines invoices
class Invoice
  include Element

  def initialize(attributes, engine = nil)
    @attributes = attributes
    @engine = engine
  end
end
