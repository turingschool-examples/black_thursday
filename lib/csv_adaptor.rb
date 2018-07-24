require 'csv'

class CsvAdaptor 
  
  def load_from_csv(file_location)
    csv_objects = CSV.read(file_location, headers: true, header_converters: :symbol)
    csv_objects.map do |object|
      object[:id] = object[:id].to_i
      object.to_h 
    end
  end  
   
end