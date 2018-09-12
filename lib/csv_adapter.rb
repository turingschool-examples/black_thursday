require 'CSV'
require 'pry'

class CsvAdapter
  def self.load(filepath)
    csv_object = CSV.open(filepath, headers: true, header_converters: :symbol)
    binding.pry
    # csv_objects.map do |object|
    #    object[:id] = object[:id].to_i
    #    object[:unit_price] = object[:unit_price].to_d
    #    object.to_h
  end
end
