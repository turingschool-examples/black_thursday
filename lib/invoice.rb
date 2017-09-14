require 'time'

class Invoice

    attr_reader :id, 
                :customer_id, 
                :merchant_id, 
                :status,
                :created_at,
                :updated_at
    
    def initialize(invoice_data, invoice_repository)
        @id = invoice_data[:id]
        @customer_id = invoice_data[:customer_id]
        @merchant_id = invoice_data[:merchant_id]
        @status = invoice_data[:status]
        @created_at = Time.parse(invoice_data[:created_at])
        @updated_at = Time.parse(invoice_data[:updated_at])
        @invoice_repository = invoice_repository
    end

end 