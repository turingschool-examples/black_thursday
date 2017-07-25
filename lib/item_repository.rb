require_relative 'item'
require 'csv'
class ItemRepository
  attr_reader :repository

  def initialize(data)
    @repository = {}
    load_csv_file(data)
  end

  def load_csv_file(data)
    CSV.foreach(data, :headers => true, :header_converters => :symbol, :converters => :all) do |row|
      data = row.to_h
      repository[data[:id].to_i] = Item.new(data)
    end
  end

end
