class Transaction
  attr_reader :id, :invoice_id

  def initialize(info)
    @id = info[:id]
    @invoice_id = info[:invoice_id]
  end
end
