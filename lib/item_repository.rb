require 'CSV'
require_relative 'item'

class ItemRepository
  attr_reader :all


  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Item.new(
        :id => row[:id].to_i,
        :name => row[:name]
        )
      end
  end

end
