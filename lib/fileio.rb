require 'csv'

# file io class
class FileIO
  def self.load(path)
    CSV.read path
  end
end
