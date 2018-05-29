require 'csv'
module FileReader
  #reads in csv files

  def self.load(path)
    CSV.read(path, headers:true, header_converters: :symbol)
  end
end
