require 'csv'

class ItemRepository

  def self.load_csv(item_csv)
    item_array = []
    CSV.foreach(@item_csv, headers: true, header_converters: :symbol) do |line|
      item_array << Item.new(line)
    end
    item_array
  end

  def initialize(item_csv)
    @item_csv = item_csv
  end

end
