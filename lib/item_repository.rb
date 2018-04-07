require 'csv'
require_relative 'item'
class ItemRepository
  attr_reader :items

  def initialize
    @items = []
  end

  def from_csv(csv)

    rows = []
    file = CSV.read(csv, headers: true)
    # binding.pry
    # file.header_convert.to_sym    # = file.headers.map do |header|
      # header.to_sym
    # end
    # do |row|
    count = file.count
    elements = (1..count).to_a.map do |index|

      # binding.pry
      file[index].to_a.map do |row|
        [row[0].to_sym, row[1]]
      end.to_h
      # binding.pry

    end

    elements.each do |element|
      @items << Item.new(element)
    end
    #   rows << row[0].split("\t")
    # end
    # rows[1]
    # # CSV.read(csv, :quote_char => "|")
  end


end
