require 'pry'
require 'csv'
require_relative './lib/invoice'

class InvoiceRepository
  def initialize(file_path, parent = nil)
    @parent = parent
    @all = []
    populate_items(file_path)
  end
end
