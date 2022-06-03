require 'helper'

class InvoiceRepository
  attr_reader :all

  def initialize(file_path)
    @file_path = CSV.foreach(file_path, headers: true, header_converters: :symbol) {|row| Invoice.new(row)}
  end

  def find_by_id(id_number)
    @all.find {|merchant| merchant.id == id_number}
  end
end
