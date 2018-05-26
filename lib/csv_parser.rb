# loads CSV files and passes them to the sales engine.
require 'csv'

class CsvParser
  def load_csv(csv_file)
    CSV.read("#{csv_file}", { encoding: "UTF-8", headers: true, header_converters: :symbol, converters: :all})
  end
end
