require 'CSV'
require './lib/cleaner'

class ItemRepository

  attr_reader :data
              :items

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

  def requirements
    @contents.find_all do |row|
      row[:id].length == 9
    end
  end

  def all
    read_contents
  end

end