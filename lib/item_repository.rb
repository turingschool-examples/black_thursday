require 'csv'
require_relative 'item'

class ItemRepository

  attr_reader :items

  def initialize(path)
    @items = []
    load_path(path)
  end

  def load_path(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @items << Item.new(data)
    end
  end
  
end
