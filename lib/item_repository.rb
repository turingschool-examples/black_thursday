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

  def find_by_name(name)
    @collection.find do |item|
      item.name == name
    end
  end

  def find_all_by_name(name)
    name_case = name.downcase
    @collection.find_all do |item|
      item.name.downcase.include?(name_case)
    end
  end

  def find_all_with_description(description)
    description_case = description.downcase
    @collection.find_all do |item|
      item.description.downcase.include?(description_case)
    end
  end

  def find_all_by_price(price)
    @collection.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @collection.find_all do |item|
      range.include?(item.unit_price.to_i)
    end
  end
end
