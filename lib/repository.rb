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
    @parsed_csv_data = []
    headers = nil
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      headers ||= row.headers
      @parsed_csv_data << row.to_h
    end
    @parsed_csv_data
  end

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
