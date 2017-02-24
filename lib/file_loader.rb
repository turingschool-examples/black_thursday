require 'csv'

class FileLoader

  def self.load_csv(path)
    CSV.open path, headers: true, header_converters: :symbol
  end

end
