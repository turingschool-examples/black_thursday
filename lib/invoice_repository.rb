require 'csv'
require_relative '../lib/invoice'

class InvoiceRepository

  attr_reader :invoices,
              :se

  def initialize(csv_file, se)
    @invoices = []
    CSV.foreach csv_file, headers: true, header_converters: :symbol do |row|
      @invoices << Invoice.new({
        id: row[:id].to_i,
        customer_id: row[:customer_id].to_i,
        merchant_id: row[:merchant_id].to_i,
        status: row[:status].to_sym ,
        created_at: Time.parse(row[:created_at]),
        updated_at: Time.parse(row[:updated_at]),
        invoice_repo: self
        })
      end
    @se = se
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find do |id_num|
      id_num.id == id
    end
  end

  def find_all_by_customer_id(id)
    @invoices.find_all do |id_num|
      id_num.customer_id.to_i == id
    end
  end

  def find_all_by_merchant_id(id)
    @invoices.find_all do |id_num|
      id_num.merchant_id.to_i == id
    end
  end

  def find_all_by_status(status_input)
    @invoices.find_all do |num|
      num.status == status_input
    end
  end

  def find_merchant_by_invoice(id)
    se.merchant_by_invoice_id(id)
  end

end
