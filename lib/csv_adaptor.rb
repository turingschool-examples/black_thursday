require 'csv'

class CsvAdaptor

  def load_merchants
    csv_objs = CSV.read("./data/merchants.csv", headers: true, header_converters: :symbol)
    csv_objs.map do |obj|
      obj[:id] = obj[:id].to_i
      obj[:name] = obj[:name]
      obj[:created_at] = obj[:created_at]
      obj[:updated_at] = obj[:updated_at]
      obj.to_h
    end
  end

end
