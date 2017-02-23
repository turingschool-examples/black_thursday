require_relative 'csv_parser'
require_relative 'item'
require_relative 'sales_engine'
require 'pry'

class ItemRepository
include CsvParser

  attr_reader :all

  def initialize(item_data)
    @all = item_data.map { |raw_item| Item.new(raw_item, self)}
  end
end
