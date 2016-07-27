# require './lib/item'

class ItemRepository
  attr_reader :items

  def initialize
    @items = []
  end

  def format_item_info(item)
    {
      :name        => item[:name],
      :description => item[:description],
      :unit_price  => item[:unit_price],
      :created_at  => item[:created_at],
      :updated_at  => item[:updated_at],
    }
  end


  def populate(items)

  end
end
