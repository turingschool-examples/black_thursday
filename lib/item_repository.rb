require_relative 'item'
require 'csv'
class ItemRepository
  attr_reader :repository

  def initialize(data)
    load_csv_file(data)
    @repository = {}
  end

  def load_csv_file(data)
    CSV.foreach(data, :headers => true, :header_converters => :symbol, :converters => :all) do |row|
      data = row.
      repository[data[:id].to_i] = Item.new(data)
    end
  end

end
