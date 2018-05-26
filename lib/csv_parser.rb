# loads CSV files and passes them to the sales engine.
require 'csv'
require 'pry'

class CsvParser
  attr_accessor :csv_file

  def initialize
    @csv_file = csv_file
  end

  def load_csv(csv_file)
    @csv_file = CSV.read("#{csv_file}", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})
  end
end
