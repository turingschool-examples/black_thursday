require 'csv'

module CsvReader

  def open_csv(path, repo)
    rows = CSV.open path, headers: true, header_converters: :symbol
    rows.each do |content|
      repo.add_data(content)
    end
  end

end
