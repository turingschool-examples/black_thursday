require 'csv'
require './lib/invoice'

class InvoiceRepository
  attr_reader :repository

  def initialize(file)
    @invoices = CSV.read(file, headers: true, header_converters: :symbol)

    @repository = @invoices.map do |invoice|
          Invoice.new({
            :id => invoice[:id],
            :customer_id => invoice[:customer_id],
            :merchant_id => invoice[:merchant_id],
            :status => invoice[:status],
            :created_at => invoice[:created_at],
            :updated_at => invoice[:updated_at]
            })
          end
  end

end
