module CsvParser

  def parser(csv_files)
    CSV.open csv_files, headers: true, header_converters: :symbol
  end

end
