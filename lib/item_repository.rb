require 'pry'
require 'csv'

class ItemRepository

  attr_reader :all
  attr_accessor

  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Item.new({:id => row[:id], :name => row[:name], :description => row[:description], :unit_price => row[:unit_price], :created_at => row[:created_at], :updated_at => row[:updated_at], :merchant_id => row[:merchant_id]})
    end
  end

  def find_by_id(id)
    @all.find do |item|
      if item.id == id
        return item
      end
    end
  end

  def find_by_name(name)
    @all.find do |item|
      if item.name.downcase == name.downcase
        return item
      end
    end
  end

  def find_all_with_description(description)
      @all.find_all do |item|
        item.description.downcase.include?(description.downcase)
    end
  end
  
  
end

# def find_all_with_description(description)
#     array = []
#     @all.select do |item|
#         # binding.pry
#         if item.description.downcase.include?(description.downcase)
#             array << item
#         end
#     end
#     array
#   end

# @all.select do |item|
#     if item.description.downcase == description.downcase
#         return item
#     end
# end
#    @all.find_all do |item|
#         if item.description.downcase.include?(description.downcase)
#             return item
#         end
#     end
    # array = []
    # @all.each do |item|
    #     if item.description.include?(description)
    #         array << item
    #     end
    # end
    # binding.pry
    # array