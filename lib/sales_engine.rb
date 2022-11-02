require 'csv'

class SalesEngine

  def self.from_csv(data)
    array = []
    CSV.foreach(data[:merchants], headers: true, header_converters: :symbol) do |row|
      array << [id: row[:id], name: row[:name]]
    end
    require "pry"; binding.pry
    array
  end
end
