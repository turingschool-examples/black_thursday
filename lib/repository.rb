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
    @parsed_csv_data = []
    parsed_csv.each do |data|
      new_hash = Hash.new
      counter = 0
      headers.each do |header|
        new_hash[header] = data[counter]
        counter += 1
      end
      @parsed_csv_data << new_hash
    end
    @parsed_csv_data
  end

  def all
    array_of_objects
  end

  def find_by_id(id)
    @array_of_objects.find do |object|
      object.id == id
    end
  end
end
