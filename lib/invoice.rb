class Invoice

  attr_accessor :id,
                :customer_id,
                :merchant_id,
                :status, 
                :created_at,
                :updated_at,
                :repo
                
  def initialize(invoice_info)
    @id = invoice_info[:id].to_i
    @customer_id = invoice_info[:customer_id].to_i
    @merchant_id = invoice_info[:merchant_id].to_i
    @status = invoice_info[:status].to_sym
    @created_at = Time.parse(invoice_info[:created_at].to_s)
    @updated_at = Time.parse(invoice_info[:updated_at].to_s)
  end

  def update_all(attributes)
    update_status(attributes)
    update_updated_at(attributes)
  end

  def update_status(attributes)
    @status = attributes[:status] if attributes[:status]
  end

  def update_updated_at(attributes)
    @updated_at = attributes[:updated_at] if attributes[:updated_at]
  end
end