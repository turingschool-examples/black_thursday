require 'csv'

class ItemRepository

  def initialize(item_csv)
    @item_csv = item_csv
  end

  def make_items
    item_array = []
    CSV.foreach(@item_csv, headers: true, header_converters: :symbol) do |line|
      item_array << Item.new(line)
    end
    item_array
  end

end
