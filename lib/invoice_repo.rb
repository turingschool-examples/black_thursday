
require 'csv'
require 'time'
require_relative 'invoice'
require_relative '../lib/load_file'

class InvoiceRepo
  attr_reader :repository,
              :parent

  def initialize(data, parent)
    @repository = data.map {|row| Invoice.new(row, self)}
    @parent = parent
  end
end
