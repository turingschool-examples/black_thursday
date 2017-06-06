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

  def transactions
    @parent.invoice_id_to_se_for_trans(self.id)
  end

  def customer
    @parent.customer_id_to_se_for_cust(self.customer_id)
  end

  def is_paid_in_full?
    transactions = self.transactions
    return false if transactions.empty?
    transactions.all? {|transaction| transaction.result == 'success'}
  end

  def total
    if self.is_paid_in_full?
      invoice_items = @parent.invoice_id_to_se_for_invoice_items(self.id)
      invoice_items.reduce(0) {|acc, item| acc += item.quantity * item.unit_price}
    end
  end
end
