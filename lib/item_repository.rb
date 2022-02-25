require 'csv'
require_relative 'item'
require 'pry'

class ItemRepository
  attr_reader :data, :items
  def inspect
  "#<\#{self.class} \#{@merchants.size} rows>"
  end

  def initialize(data)
    @data = data
  end

  def all
    # binding.pry
      @items =[]
      CSV.foreach(@data, headers: true, header_converters: :symbol) do |row| header ||= row.headers
      @items << Item.new(row)
      end
    @items
  end
    # @items = []
    # @data.each_with_index do |line, index|
    #   next if index == 0
    #   columns = line.split(",")
    #   @items << Item.new({id: columns[0], name: columns[1], description: columns[2], unit_price: columns[3], merchant_id: columns[4], start_date: columns[5], end_date: columns[6]})
    #
    # end

  end
