require_relative 'invoice'

class InvoiceRepository

  attr_reader :file_path,
              :sales_engine,
              :id_repo

  def initialize(file_path, sales_engine)
    @file_path    = file_path
    @sales_engine = sales_engine
    @id_repo      = {}
    load_repo
  end

  def load_repo
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      invoice_info = Hash[row]
      invoice_identification = invoice_info[:id]
      invoice = Invoice.new(invoice_info, self)
      @id_repo[invoice_identification.to_i] = invoice
    end
  end

  def all
    id_repo.map do |id, invoice_info|
      invoice_info
    end
  end

end
