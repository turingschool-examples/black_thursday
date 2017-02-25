class Invoice

  attr_reader :invoice_hash, :repository

  def initialize(hash, repository = '')
    @invoice_hash = hash
    @repository = repository
  end

  def id
    invoice_hash[:id]
  end

  def customer_id
    invoice_hash[:customer_id]
  end

  def merchant_id
    invoice_hash[:merchant_id]
  end

  def status
    invoice_hash[:status]
  end

  def created_at
    invoice_hash[:created_at]
  end

  def updated_at
    invoice_hash[:updated_at]
  end
end
