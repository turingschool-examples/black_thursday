require_relative './sales_engine'

class ItemRepository

  def initialize(file_path)
    @file_path = file_path.to_s
  end

  def read_csv
    collection_array = []
    data = CSV.parse(File.read(@file_path), headers: true) do |line|
      collection_array << line.to_h
    end
    collection_array
  end

end
