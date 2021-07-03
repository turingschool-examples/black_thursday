require 'CSV'
require 'pry'

class CsvAdaptor
  def load_from_csv (file_path)
    csv_objects = CSV.open(file_path, headers: true, header_converters: :symbol)
    csv_objects.map do |object|
      object[:id] = object[:id].to_i
      object.to_h
    end
  end
end