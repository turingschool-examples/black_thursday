require 'csv'

module FileExtractor

  def self.extract_data(load_path)
    CSV.read(load_path, headers: true, header_converters: :symbol)
  end
end
