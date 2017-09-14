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
end 