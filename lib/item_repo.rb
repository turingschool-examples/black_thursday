require 'csv'

class ItemRepo
  attr_reader :item_list

  def initialize(input)
    make_items(input)
  end

  def make_items(input)
    items = CSV.open(input, headers: true,
    header_converters: :symbol)

    @item_list = items.map do |item|
      Item.new(item)
    end
  end

  def all
    item_list
  end
end
