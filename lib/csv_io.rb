module CSV_IO

  def load_csv_data
    all_data = get_csv_data
    all_data.map do |row|
      add_new(row, sales_engine)
    end
  end

  def get_csv_data
    CSV.open(file, headers: true, header_converters: :symbol)
  end

end
