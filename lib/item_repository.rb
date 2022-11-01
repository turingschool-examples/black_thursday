require './lib/item'

class ItemRepository
  def initialize(stats)
    @items = []
    stats.each {|stat| create(stat)}
  end

  def create(stat)
    stat[:id] ||= (@items.last.id.to_i + 1).to_s
    item = Item.new(stat)
    @items.push(item)
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find {|item| item.id == id.to_s}
  end

  def find_by_name(name)
    @items.find {|item| item.name.downcase == name.downcase}
  end

  def find_by_description(description)
    @items.select {|item| clean_description(item.description) == clean_description(description)}
  end

  def find_all_by_price(price)
    @items.select {|item| item.unit_price_to_dollars == price}
  end

  def find_all_by_price_range(range)
    @items.select {|item| range.include?(item.unit_price.to_f)}
  end

  def find_all_by_merchant_id(merchant_id)
    @items.select {|item| item.merchant_id == merchant_id.to_s}
  end

  def clean_description(desc)
    desc.downcase.gsub(/\s+/, "").gsub(/\n+/, "")
  end

  def update(id, attributes)
    find_by_id(id).update(attributes)
  end

  def delete(id)
    @items.delete(find_by_id(id))
  end
end