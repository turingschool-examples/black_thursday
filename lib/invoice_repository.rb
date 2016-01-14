require 'bigdecimal'
require 'invoice'
require 'csv_loader'
require 'finder'

class InvoiceRepository
include CsvLoader
include Finder
attr_reader :all

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def initialize(invoice_file)
    data_into_hash(load_data(invoice_file))
  end

  def data_into_hash(data)
    @all ||= data.map do |row|
      invoice_id = row[:id]
      customer_id = row[:customer_id]
      created_at = row[:created_at]
      updated_at = row[:updated_at]
      status = row[:status]
      merchant_id = row[:merchant_id]

      hash = {:id => invoice_id,
              :customer_id => customer_id, :merchant_id => merchant_id,
              :status => status,
              :created_at => created_at, :updated_at => updated_at}
      Invoice.new(hash)
    end
  end

end
