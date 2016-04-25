require 'csv'

class CsvParser

  def collect_data(paths)
    hash = {}
    paths.each do |data_type, path|
      contents = CSV.open path, headers: true, header_converters: :symbol
      hash[data_type] = contents.map { |row| row.to_h }
    end
    hash
  end
end
