require 'csv'

class CsvAdaptor

  def load_merchants(data_file)
    csv_objs = CSV.read(data_file, headers: true, header_converters: :symbol)
    csv_objs.map do |obj|
      obj[:id] = obj[:id].to_i
      obj[:name] = obj[:name]
      obj[:created_at] = obj[:created_at]
      obj[:updated_at] = obj[:updated_at]
      obj.to_h
    end
  end

end
