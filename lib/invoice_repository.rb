require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require 'csv'
require_relative 'invoice'

class InvoiceRepository

  attr_reader :file_path,
              :contents

  def initialize(file_path, parent)
    @file_path = file_path
    @parent    = parent
    @contents  = load_library
  end

  def load_library
    library = {}
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      h = Hash[row]
      d = h[:id]
      library[d] = Invoice.new(h, self)
    end
    @contents = library
  end

end
