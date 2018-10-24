class ItemRepository
  def initialize(data)
    @item_data = CSV.open(data, headers: true, header_converters: :symbol)
    @collection = []
  end

  def items
    @item_data.each do |row|
      @collection << Item.new({
                               id: row[:id].to_s,
                               name: row[:name].to_s,
                               description: row[:description].to_s,
                               unit_price: row[:unit_price].to_s,
                               merchant_id: row[:merchant_id].to_s,
                               created_at: row[:created_at].to_s,
                               updated_at: row[:updated_at].to_s
                             })
    end
    @collection
  end

  def all
    @collection
  end

  def find_by_id(id)
    @collection.find do |item|
      item.id == id
    end
  end
end
