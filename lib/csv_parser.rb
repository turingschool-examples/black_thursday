# loads CSV files and passes them to the sales engine.
require 'csv'
require 'pry'

class CsvParser
  attr_accessor :csv_file

  def initialize
    @csv_file = csv_file
  end

  def load_csv(csv_file)
    data = CSV.foreach(csv_file, headers: true, header_converters: :symbol, converters: :all).map { |row| row.to_h }
    return data
  end
end
