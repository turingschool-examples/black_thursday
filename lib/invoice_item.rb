require 'bigdecimal'

class InvoiceItem
  attr_reader :id

  def initialize(attributes)
    @id = attributes[:id]
  end
end
