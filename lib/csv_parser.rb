require 'csv'

class CsvParser

  def merchant(csv_content)
    contents = CSV.open csv_content, headers: true, header_converters: :symbol
    id = []
    name = []
    contents.each do |row|
      id << row[:id]
      name << row[:name]
    end
    :id[id]
  end

  # def items()
  # end
end
