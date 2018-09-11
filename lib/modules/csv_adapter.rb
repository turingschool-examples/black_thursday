require 'csv'

module CSVAdapter

  def hash_from_csv(filename)
    data = []
    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      data << row.to_h
    end
    return data
  end

end
