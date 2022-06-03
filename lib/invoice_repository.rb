require 'CSV'

class InvoiceRepository
  attr_reader :all

  def initialize(filepath)
    @filepath = filepath
    @all = []
      CSV.foreach(@filepath, headers: true, header_converters: :symbol) do |row|
        @all << Invoice.new(id: row[:id], merchant_id: row[:merchant_id], status: row[:status], created_at: row[:created_at], updated_at: row[:updated_at])
      end
    end

  def find_by_id(id)
    @all.find do |invoice|
      invoice.id == id
    end
  end

end
