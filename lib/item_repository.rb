require 'CSV'
require_relative 'item'
require 'pry'

class ItemRepository
  attr_reader :all


  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Item.new(
        :id => row[:id].to_i,
        :name => row[:name],
        :description => row[:description].delete("\n"),
        :unit_price => row[:unit_price],
        :created_at => row[:created_at],
        :updated_at => row[:updated_at],
        :merchant_id => row[:merchant_id]
        )
      end
  end

  def find_by_id(id)
    @all.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @all.find do |item|
      item.name.upcase == name.upcase
    end
  end

  def find_all_with_description(description_fragment)
    @all.find_all do |item|
      item.description.upcase.include?(description_fragment.upcase)
    end
  end

end
