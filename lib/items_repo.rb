require 'CSV'
require 'pry'
require './lib/item'

class ItemsRepo
  def initialize(file_path)
    @items = []
    populate(file_path)
  end

  def populate(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |params|
      @items << Item.new(params)
    end
  end

end
