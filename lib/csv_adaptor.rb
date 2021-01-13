require 'csv'

module CsvAdaptor


  def load_from_csv(file_location)
    csv_objects = CSV.open(file_location, headers: true, header_converters: :symbol)
    csv_objects.map do |object|
      object[:id] = object[:id].to_i
      object.to_h
    end
  end


end
