module FileOpener
  def open_csv(filename)
    CSV.foreach(filename,
    headers: true, header_converters: :symbol)
  end
end
