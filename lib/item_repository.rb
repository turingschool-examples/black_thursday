require_relative 'item'

class ItemRepository
  attr_reader :item_data, :all, :parent

  def initialize(item_data, parent = nil)
    @item_data = item_data
    @all = item_data.map { |row| Item.new(row, self) }
    @parent = parent
  end

  def find_by_id(id)
    all.find {|object| object.id == id }
  end

  def find_by_name(name)
    all.find { |object| object.name.downcase == name.downcase }
  end


  def find_all_with_description(search_term)
    all.find_all { |object| object.description.downcase.include?(search_term.downcase) }
  end

  def find_all_by_price(price)
    all.find_all do |object|
      object.unit_price.to_f == price
    end
  end

  def find_all_by_price_in_range(range)
    all.find_all do |object|
      (range).include?(object.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all { |object| object.merchant_id == merchant_id}
  end

  def inspect
    @instance.nil? ? nil : "#<#{self.class} #{@instance.size} rows>"
  end

end
