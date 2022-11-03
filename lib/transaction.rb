class Transaction
  attr_accessor :id, :invoice_id

  def initialize(data)
    @id = data[:id].to_i
    @invoice_id = data[:invoice_id].to_i
  end
end