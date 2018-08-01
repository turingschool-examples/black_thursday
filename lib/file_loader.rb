require "csv"

module FileLoader
  def builder(file)
    CSV.open(file, headers: true, header_converters: :symbol)
  end
end
