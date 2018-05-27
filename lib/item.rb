class Item
  attr_reader :item_specs

  def initialize(item)
    @item_specs = {
      id:            item[:id].to_i,
      name:          item[:name],
      description:   item[:description],
      unit_price:    item[:unit_price],
      created_at:    item[:created_at].to_s,
      updated_at:    item[:updated_at].to_s
    }
  end

end
