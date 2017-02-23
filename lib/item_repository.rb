require_relative 'csv_parser'
require_relative 'item'
require_relative 'sales_engine'

class ItemRepository
include CsvParser

  attr_reader :all

  def initialize(item_data)
    @all = item_data.map { |raw_item| Item.new(raw_item, self)}
  end

  def find_by_id(id)
    @all.find do |item|
      id == item.id
    end
  end
  
  def find_by_name(name)
    @all.find do |item|
      name == item.name
    end  
  end

  def find_all_with_description(fragment)
       # please refactor me /select/
    items = all.map do |item|
      if item.description.downcase.include?(fragment.downcase)
        item 
      end
    end
    items.compact
  end
  
end
