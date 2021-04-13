require './lib/items'
require 'csv'

class ItemRepo

  def initialize(csv_files)
    @item_list = item_instances(csv_files)
  end

  def item_instances(csv_files)
    items = CSV.open(csv_files, headers: true,
    header_converters: :symbol)

    @item_list = items.map do |item|
      Item.new(item)
    end
  end
end


# CSV.foreach(csv_files, headers: true, header_converters: :symbol) do |row|
