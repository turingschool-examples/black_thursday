require 'CSV'
require './lib/cleaner'

class ItemRepository

  attr_reader :data

  def initialize(file='./data/items.csv')
    @file = file
    @cleaner = Cleaner.new
    @items = []
    # @data = CSV.open @file, headers: true, header_converters: :symbol
    @contents = @cleaner.open_csv(@file)
  end

  def read_contents
    File.read(@file)
  end

  def all
    read_contents
  end

end
