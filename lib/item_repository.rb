require 'CSV'
require 'item'

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


  def find_all_by_price_in_range(range)
    min = range.min
    max = range.max
    # require "pry"; binding.pry
    @all.find_all do |item|
      item.unit_price.to_i.between?(min, max)
  end

  end
    # price_range = []
    # require "pry"; binding.pry
    # @all.each do |price|
    #   if price.range == @item.price
    #     price_range << @item
    #   end
    # end
    #   price_range
    # end


end
