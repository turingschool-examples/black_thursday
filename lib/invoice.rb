class Invoice
  attr_reader :id

  def initialize(invoice)
    @id = invoice[:id]
  end

end
