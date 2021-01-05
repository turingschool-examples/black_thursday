require 'CSV'
require './lib/items'
require 'time'
require 'bigdecimal'
require 'bigdecimal/util'
class ItemsRepo
  attr_reader :items
  def initialize(data)
    @data = data
    @items = populate_items
  end

  def populate_items
    items = []
    CSV.foreach(@data, headers: true, header_converters: :symbol) do |row|
      items << Item.new({:id => row[:id],
                          :name => row[:name],
                          :description => row[:description],
                          :unit_price => row[:unit_price],
                          :merchant_id => row[:merchant_id],
                          :created_at => row[:created_at],
                          :updated_at => row[:updated_at]
                         })
    end
    items
  end

  def all
    @items
  end

  def find_by_id (id)
    @items.find do |item|
      item.id == id
    end
  end

end