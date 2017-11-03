require_relative './item'

class ItemRepository
  attr_reader :items,
              :parent

  def initialize(items, parent)
    @items = items.map {|item| Item.new(item, self)}
    @parent = parent
  end

  def all
    items
  end

  def sort_by(attribute)
    items.sort_by do |item|
      item.send(attribute)
    end
  end

  def find_by_id(id)
    items.bsearch do |item|
      item.id.to_s >= id.to_s
    end
  end

  def find_by_name(name)
    sort_by('name').bsearch do |item|
      item.name.downcase >= name.downcase
    end
  end

  def find_all_with_description(phrase)
    items.find_all do |item|
      item.description.downcase.include?(phrase.downcase)
    end
  end

  def find_all_by_price(price)
    sorted_items = sort_by('unit_price')
    return [] if sorted_items.last.unit_price < price
    start_index = sorted_items.bsearch_index do |item|
      item.unit_price >= price
    end
    result = []
    while sorted_items[start_index].unit_price == price
      result << sorted_items[start_index]
      sorted_items.delete_at(start_index)
      return result if sorted_items[start_index].nil?
    end
    result
  end

  def find_all_by_price_in_range(range)
    sorted_items = sort_by('unit_price')
    return [] if sorted_items.last.unit_price > range.last
    start_index = sorted_items.bsearch_index do |item|
      item.unit_price >= range.first
    end
    result = []
    while range.include?(sorted_items[start_index].unit_price)
      result << sorted_items[start_index]
      sorted_items.delete_at(start_index)
      return result if sorted_items[start_index].nil?
    end
    result
  end

  def find_all_by_merchant_id_slow(id)
    items.find_all do |item|
      item.merchant_id.to_s == id.to_s
    end
  end

  def find_all_by_merchant_id(id)
    sorted_items = sort_by('merchant_id')
    return [] if sorted_items.last.merchant_id < id
    start_index = sorted_items.bsearch_index do |item|
      item.merchant_id.to_s >= id.to_s
    end
    result = []
    while sorted_items[start_index].merchant_id == id
      result << sorted_items[start_index]
      sorted_items.delete_at(start_index)
      return result if sorted_items[start_index].nil?
    end
    result
  end

  def find_merchant_by_id(merchant_id)
    parent.find_merchant_by_id(merchant_id)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
