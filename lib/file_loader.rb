require 'csv'

module FileLoader
  def load_file(file_name)
    CSV.open file_name, headers: true, header_converters: :symbol
  end
end
