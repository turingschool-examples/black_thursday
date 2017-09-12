require './lib/item'
require 'csv'

class ItemRepository
  attr_reader :items
  def initialize(file_path)
    @items = []
    load_csv(file_path)
  end


  def load_csv(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol, converters: :numeric ) do |item|
      @items<< Item.new(item.to_h)
    end
  end

  def all
    @items
  end





end
