require 'csv'

class CSVAdapter

  def initialize(filename, header)
    @filename = filename
    @header = header
  end

  # TODO: Update to work with black thursday
  # def array_of_strings
  #   strings = []
  #   CSV.foreach(@filename, :headers => true) do |row|
  #     strings << row[@header]
  #   end
  #   return strings
  # end

end
