require 'csv'

module FileLoader

  def open_items_csv(file_path)
    CSV.open(file_path, headers: true, header_converters: :symbol)
  end

end
