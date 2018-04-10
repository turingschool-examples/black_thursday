require_relative 'element'

# This class defines invoices
class Invoice
  include Element

  def initialize(attributes)
    @attributes = attributes
  end
end
