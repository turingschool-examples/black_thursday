require 'pry'
require './lib/item'
require 'csv'

class ItemRepo
  attr_reader :items

  def initialize(file)
    open_file(file)
#    self
  end

  def open_file(file)
    csv = CSV.foreach file,
    headers: true, header_converters: :symbol
    @items = csv.map do |row|
      Item.new(row)
    end
  end

  def all
    items
  end

  def find_by_id(id)
    items.find { |item| item.id == id }
  end

  def find_by_name(name)

  end
end
