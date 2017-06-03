class CsvReader

  def self.read_file(file_path)
    CSV.open(file_path,
             headers: true,
             header_converters: :symbol)
  end
end
