require 'CSV'
require_relative 'item'

class ItemRepository
  attr_reader :file_path,
              :all

  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Item.new({:id => row[:id], :name => row[:name], :description => row[:description], :unit_price => row[:unit_price], :created_at => row[:created_at], :updated_at => row[:updated_at], :merchant_id => row[:merchant_id]})
    end
  end

  def find_by_id(id)
    @all.find { |id| id }
  end

end
# require 'pry'; binding.pry
