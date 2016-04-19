require 'csv'

class CsvParser

  def merchants(csv_content)
    contents = CSV.open csv_content, headers: true, header_converters: :symbol
    id = []
    name = []
    contents.each do |row|
      id << row[:id]
      name << row[:name]
    end
    array = id.zip(name).to_h.map do |key, value|
      { :id => key, :name => value }
    end
    array
  end

  # def items()
  # end
end
