class InvoiceItem
  attr_reader :id
  def initialize(data, sales_engine)
    @id = data[:id].to_i
  end
end
