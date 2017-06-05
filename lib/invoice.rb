class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(params = {}, parent = nil)
    @parent      = parent
    @id          = params['id'].to_i
    @customer_id = params['customer_id'].to_i
    @merchant_id = params['merchant_id'].to_i
    @status      = params['status'].to_sym
    @created_at  = Time.parse(params['created_at'])
    @updated_at  = Time.parse(params['updated_at'])
  end

  def merchant
    @parent.mid_to_se(self.merchant_id)
  end

  def items
    @parent.invoice_id_to_se(self.id)
  end
end
