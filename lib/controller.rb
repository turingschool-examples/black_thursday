require 'pry'
require 'csv'

class Controller

  def parse_file
    file = CSV.open @filename,  headers: true, header_converters: :symbol
  end
end
