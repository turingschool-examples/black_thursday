require 'csv'

module DataParser
  def self.parse_data(filename)
    handle = CSV.open filename, headers: true, header_converters: :symbol
    parsed_rows = handle.map{|row| row}
  end
end
