require 'CSV'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class Repository
  attr_reader :parsed_csv_data

  def initialize(path)
    @parsed_csv_data = parse_csv(path)
    @array_of_objects = [] #consider a rename #NEED TO UPDATE CHILD CLASSES TO USE THIS NAME
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

end
