require 'csv'

module CSV_parser

  def parse(file)
    CSV.open file, headers: true, header_converters: :symbol
  end
  
end