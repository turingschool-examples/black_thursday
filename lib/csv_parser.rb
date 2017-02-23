require 'csv'
require 'pry'

module CsvParser
  def open_file(file)
    CSV.open file, headers: true, header_converters: :symbol 
  end
end
