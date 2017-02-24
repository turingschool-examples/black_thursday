require_relative 'item'

class ItemRepository
  attr_reader :item_data, :all

  def initialize(item_data)
    @item_data = item_data
    @all = item_data.map { |row| Item.new(row) }
  end

  def find_by_id(id)
    all.find {|object| object.id.to_i == id }
  end

  def find_by_name(name)
    all.find { |object| object.name.downcase == name.downcase }
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_by_description(search_term)
    all.find_all { |object| object.description.downcase.include?(search_term.downcase) }
  end

  def find_all_by_price(price)
    all.find_all { |object| object.unit_price == price }
  end

  def find_all_by_price_in_range(range)
    all.find_all do |object|
      (range).include?(object.unit_price)
    end
  end

end
