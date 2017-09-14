require_relative 'csv_parser'
require_relative 'invoice'


class InvoiceRepository
    include CsvParser
    attr_reader :sales_engine
    attr_accessor :invoices

    def initialize(file_name, sales_engine)
        
        @invoices = []
        invoice_contents = parse_data(file_name)
        invoice_contents.each do |row|
            @invoices << Invoice.new(row, self)
        end 
        @sales_engine = sales_engine
    end 

    def all
        @invoices
    end 
    
    def find_by_id(id)
        @invoices.find {|invoice| invoice.id == id }
    end

    def find_all_by_customer_id(id)
        @invoices.select {|invoice| invoice.customer_id == id }
    end

    def find_all_by_merchant_id(id)
        @invoices.select {|invoice| invoice.merchant_id == id }
    end 

    def find_all_by_status(status)
        @invoices.select {|invoice| invoice.status == status}
    end 

    def inspect
    "#<#{self.class} #{@merchants.size} rows>"
    end
end 