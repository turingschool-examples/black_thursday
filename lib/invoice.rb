class Invoice
attr_reader :id,
            :created_at,
            :customer_id,
            :merchant_id,
            :invoice_repository

attr_accessor :status,
              :updated_at

  def initialize(info, invoice_repository)
    @id                 = info[:id].to_i
    @customer_id        = info[:customer_id].to_i
    @merchant_id        = info[:merchant_id].to_i
    @status             = info[:status].to_sym
    @created_at         = Time.parse(info[:created_at])
    @updated_at         = Time.parse(info[:updated_at])
    @invoice_repository = invoice_repository
  end
end
