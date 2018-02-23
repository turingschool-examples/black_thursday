class InvoiceItem
  attr_reader :id

  def initialize(data)
    @id = data[:id].to_i
  end 

end
