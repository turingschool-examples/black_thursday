class ItemRepository
  attr_reader :items

  def initialize(item)
    @items = item
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item.description.downcase == description.downcase
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price_to_dollars == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      range.include?(item.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    new_id = @items.max_by do |item|
      item.id
    end
    item = Item.new({
      :id => new_id.id + 1,
      :name => attributes[:name],
      :description => attributes[:description],
      :unit_price => BigDecimal(attributes[:unit_price],4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => attributes[:merchant_id]
      })
    @items << item
    item
  end

  def update(id, attributes)
    info_edit = find_by_id(id)
    info_edit.name = attributes[:name]
    info_edit.description = attributes[:description]
    info_edit.unit_price = BigDecimal(attributes[:unit_price],4)
    info_edit.updated_at = Time.now
  end

  def delete(id)
    delete_item = find_by_id(id)
    @items.delete(delete_item)
  end
end
