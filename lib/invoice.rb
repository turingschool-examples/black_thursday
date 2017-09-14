require 'time'

class Invoice

    attr_reader :id, 
                :customer_id, 
                :merchant_id, 
                :status,
                :created_at,
                :updated_at
    
    def initialize(invoice_data, invoice_repository)
        @id = invoice_data[:id].to_i
        @customer_id = invoice_data[:customer_id].to_i
        @merchant_id = invoice_data[:merchant_id].to_i
        @status = invoice_data[:status].to_sym
        @created_at = Time.parse(invoice_data[:created_at])
        @updated_at = Time.parse(invoice_data[:updated_at])
        @invoice_repository = invoice_repository
    end

    def merchant
        @invoice_repository.sales_engine.merchants.find_by_id(@merchant_id)
    end 
end 