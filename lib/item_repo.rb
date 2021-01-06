require 'CSV'

class ItemRepository

  attr_reader :data

  def initialize(file='./data/items.csv')
    @file = file
    @items = []
    @data = CSV.open @file, headers: true, header_converters: :symbol
  end

  def all
    
  end





end
