require './lib/item.rb'
class ItemRepository

  def initialize
    @items = []
  end

  def csv_reader(path)
    CSV.open path, headers: true, header_converters: :symbol
  end

  def item_creator_and_storer
    csv_reader(path).each do |item|
      @items << Item.new(item, self)
    end
  end

end
