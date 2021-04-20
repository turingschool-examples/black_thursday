require 'CSV'
require_relative '../lib/sales_engine'

class Repository
  attr_reader :parsed_csv_data,
              :array_of_objects

  def initialize(path)
    @parsed_csv_data = parse_csv(path)
    @array_of_objects = []
  end

  def inspect
  "#<#{self.class} #{@array_of_objects.size} rows>"
  end

  def parse_csv(path)
    parsed_csv = CSV.parse(File.read(path), headers: true, header_converters: :symbol).to_a
    headers = parsed_csv.shift
    @parsed_csv_data = parsed_csv.reduce([]) do |parsed_data, raw_data|
      new_hash = Hash.new
      counter = 0
      headers.each do |header|
        new_hash[header] = raw_data[counter]
        counter += 1
      end
      parsed_data << new_hash
      parsed_data
    end
    @parsed_csv_data
  end
  #foreach in CSV. instead of reading it takes the file and does the reading/formating for you. gives you a row object that behaves like a hash.

  #send the path and class and as we iterate over csv we create object. OR send create method the type of object we want to create. (with capital letter(class not instance))

  
  def all
    array_of_objects
  end

  def find_by_id(id)
    array_of_objects.find do |object|
      object.id == id
    end
  end

  def delete(id)
    target = find_by_id(id)
    array_of_objects.delete(target)
  end

end
