require 'time'
require './lib/invoice'
require 'csv'

class InvoiceRepository
  include TimeStoreable

  attr_reader :all
  
  def initialize(data, engine)
    @all    = []
    @engine = engine


     CSV.foreach(data, headers: true, header_converters: :symbol) do |row|
      @all << convert_to_invoice(row)
    end
  end

  def convert_to_invoice(row)
    row = Invoice.new({id: row[:id],                    
                    customer_id: row[:customer_id],
                    merchant_id: row[:merchant_id],
                    status: row[:status],
                    created_at: row[:created_at],
                    updated_at: row[:updated_at]
                   }, self)
  end
end