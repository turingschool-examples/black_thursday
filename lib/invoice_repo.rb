require 'pry'

class InvoiceRepository
  attr_reader :file_path, :invoices
  def initialize(file_path)
    @file_path = file_path
    @invoices = all
  end

  def all
    invoices = CSV.read(@file_path, headers: true, header_converters: :symbol)
    invoices_instances_array = []
    invoices.by_row!.each do |row|
      invoices_instances_array << Invoice.new(row)
    end
    invoices_instances_array
  end

  def find_by_id(id)
    @invoices.find do |invoice_instance|
      invoice_instance.invoice_attributes[:id] == id
    end
  end
end
