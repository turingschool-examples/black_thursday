require 'csv'

class Invoice
  attr_reader :id, :customer_id, :merchant_id, :created_at
  attr_accessor :status, :updated_at
  def initialize(data)
    @id = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status = data[:status].to_sym
    @updated_at = data[:updated_at]
    @created_at = data[:created_at]
  end

  def self.read_file(csv)
    invoice_rows = CSV.read(csv, headers: true, header_converters: :symbol)
    invoice_rows.map do |row|
      new(row)
    end
  end

end
