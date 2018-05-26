require 'csv'

class FileLoader

  def load_file(file)
    CSV.open file, headers: true, header_converters: :symbol
  end
end

fl = FileLoader.new
fl.load_file("./data/merchants.csv")
