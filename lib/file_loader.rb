require "csv"

module FileLoader
  def file_builder(file)
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      row
    end
  end
end
