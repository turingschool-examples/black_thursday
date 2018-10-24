require 'pry'
require 'CSV'
require './lib/merchant'
require './lib/sales_module'

class ItemRepository

  include Repository

  attr_reader :repository

  def initialize(csv_items)
    @repository  = []
    create_item(csv_items)
  end

  def create_item(csv_items)
    row_objects = CSV.read(csv_items, headers: true, header_converters: :symbol)
      @repository = row_objects.map do |row|
        Item.new(row)
      end
  end

  # def all
  #   @items
  # end

  # def find_by_id(id)
  #   @items.find do |item|
  #     item.id == id
  #   end
  # end

end
