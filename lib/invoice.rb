# invoice class
class Invoice
  include Elementals

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :created_at

  attr_accessor :status,
                :updated_at

  def initialize(invoice_hash = Hash.new(0))
    @id          = invoice_hash[:id].to_i
    @customer_id = invoice_hash[:customer_id].to_i
    @merchant_id = invoice_hash[:merchant_id].to_i
    @status      = invoice_hash[:status].to_sym
    @created_at  = format_time(invoice_hash[:created_at])
    @updated_at  = format_time(invoice_hash[:updated_at])
  end
end
