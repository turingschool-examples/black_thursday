class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :created_at,
              :repository
  attr_accessor :updated_at,
                :status

  def initialize(invoice_info)
    @id = invoice_info[:id].to_i
    @customer_id = invoice_info[:customer_id].to_i
    @merchant_id = invoice_info[:merchant_id].to_i
    @status = invoice_info[:status].to_sym
    @created_at = invoice_info[:created_at]
    @updated_at = invoice_info[:updated_at]
    @repository = repository
  end

  def update(attributes)
    @status = attributes[:status].to_sym unless attributes[:status].nil?
    @updated_at = Time.now
  end
end
