require "csv"
require_relative "find"

class ItemRepository
include Find
  attr_reader :items
  
  def initialize(csv_file)
    @csv_file = csv_file
    @items = []
  end
end