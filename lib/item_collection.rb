require 'CSV'
require "./lib/item"
class ItemCollection

  attr_reader :all
  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters:      :symbol) do |row|
      @all << Item.new(:id => row[:id], :name => row[:name], :description => row[:description], :unit_price => row[:unit_price], :created_at => row[:created_at], :updated_at => row[:updated_at], :merchant_id => row[:merchant_id])
      end
  end

  def find_by_id(id)
    @all.find {|item| item.id == id}
  end

  def find_by_name(name)
    @all.find {|item| item.name.upcase == name.upcase}
  end

  # def find_all_with_description(description)
  #   # require "pry"; binding.pry
  #   @all.find_all do |item|
  #   require "pry"; binding.pry
  #   # {item.description.include?(description.upcase)}
  # end
  # end

end
