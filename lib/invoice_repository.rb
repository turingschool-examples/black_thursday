require 'pry'
require 'csv'
require_relative 'invoice'

class InvoiceRepository

  attr_reader :all

  def initialize(file_path, parent = nil)
    @parent = parent
    @all = []
    populate_invoices(file_path)
  end

  def populate_invoices(file_path)
    CSV.foreach(file_path, row_sep: :auto, headers: true) do |line|
      self.all << Invoice.new(line, self)
    end
  end

  def find_by_id(id)
    @all.find do |invoice|
      invoice.id == id
    end
  end

end
