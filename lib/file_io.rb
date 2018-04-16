require 'csv'

# file io class
class FileIO
  def self.load(path)
    CSV.read(path, headers: true, header_converters: :symbol)
  end
end
