require 'date'
class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :created_time
  def initialize(hash, parent)
    @id = hash[:id].to_i
    @customer_id = hash[:customer_id].to_i
    @merchant_id = hash[:merchant_id].to_i
    @status = hash[:status].to_sym
    @created_at = Date.parse(hash[:created_at])
    @created_time = hash[:created_time]
    @parent = parent
  end

  def merchant
    @parent.invoice_repo_finds_merchant_via_engine(self.id)
  end
end
