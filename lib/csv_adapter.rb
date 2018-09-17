require 'CSV'

class CsvAdapter
  def self.load(filepath)
    csv_object = CSV.open(filepath, headers: true, header_converters: :symbol)
  end
end
