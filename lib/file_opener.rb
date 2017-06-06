module FileOpener
  def open_csv(filename)
    file_output = CSV.foreach(filename,
    headers: true, header_converters: :symbol)
  end
end
