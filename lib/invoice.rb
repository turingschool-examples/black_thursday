class Invoice
  attr_reader :id, :name, :customer_id, :merchant_id, :status
  def initialize(data, repo = nil)
    @id = data[:id].to_i
    @name = data[:name]
    @customer_id = data[:customer_id]
    @merchant_id = data[:merchant_id]
    @status = data[:status]
    @parent = repo
  end
end
