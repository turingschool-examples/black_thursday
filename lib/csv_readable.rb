module CSV_readable
  def read_csv(path)
    CSV.read(path, headers: true, header_converters: :symbol)
  end
end
