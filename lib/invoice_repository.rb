require 'csv'
require_relative '../lib/invoices'



class InvoiceRepository

  attr_reader :invoices_csv,
              :invoices,
              :se

  def initialize(csv_file, se)
    @invoices_csv = CSV.foreach(csv_file, headers: true, header_converters: :symbol)
    @invoices = []
    @se = se
    invoices_csv.each do |row|
      id    =  row[:id]
      customer_id  =  row[:customer_id]
      merchant_id =  row[:merchant_id]
      status    =   row [:status]
      created_at =  row[:created_at]
      updated_at = row[:updated_at]
      @invoices << Invoices.new({
        id: id,
        customer_id: customer_id,
        merchant_id: merchant_id,
        status:   status,
        created_at: created_at,
        updated_at: updated_at,
        invoice_repo: self
        })
    end

  end


  def all
    @invoices
  end

end
