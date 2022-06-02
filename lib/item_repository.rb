require 'CSV'
require 'item'

class ItemRepository
  attr_reader :file_path,
              :all_items

  def initialize(file_path)
    @file_path = file_path
    @all_items = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all_items << Item.new({:id => row[:id], :name => row[:name], :description => row[:description], :unit_price => row[:unit_price], :created_at => row[:created_at], :updated_at => row[:updated_at], :merchant_id => row[:merchant_id]})
    end
  end

  def find_all_by_price_in_range(range)
    min = range.min
    max = range.max

    @all_items.find_all do |item|
      item.unit_price.to_i.between?(min, max)
    end
  end


end
