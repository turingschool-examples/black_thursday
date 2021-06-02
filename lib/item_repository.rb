require './item'
require 'CSV'

class ItemRepository
  attr_reader :all
  
  def initialize(path)
    @all = create_items(path)
    # @engine = engine
  end

  def create_items(path)
    items = CSV.read(path, headers: true, header_converters: :symbol)
    items.map do |item_data|
      Item.new(item_data)
    end
  end

end
