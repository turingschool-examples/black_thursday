require "csv"

class FileLoader

  attr_accessor   :file

  def initialize(file)
    @file = file
  end

  def builder(file)
    CSV.foreach(file, headers: true, header_converters: :symbol).map(&:to_h)
  end
end
