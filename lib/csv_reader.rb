class CsvReader


def read_file(file_path)
contents = CSV.open file_path, headers: true, header_converters: :symbol
end
