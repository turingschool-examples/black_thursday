require 'csv'

class CsvParser

  def merchants(merchants)
    contents = CSV.open merchants, headers: true, header_converters: :symbol
    contents.map do |row|
      row.to_h
    end
  end


  def items(items)
    contents = CSV.open items, headers: true, header_converters: :symbol
    contents.map do |row|
      row.to_h
    end
  end

end
