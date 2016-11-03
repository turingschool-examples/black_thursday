require_relative 'items'

class ItemRepository
  attr_reader   :all,
                :parent

  def initialize(item_data, parent = nil)
    @parent = parent
    @all = []
    populate(item_data)
  end

  def populate(item_data)
    item_data.each do |item|
      @all << Merchant.new(item, self)
      # add_merchant(merchant)
    end
  end

  def add_item(item_data)
    @all_items << Item.new(item_data, self)
  end

  def find_by_id(id)
    @all_items.find { |item| item.id.eql?(id) }
  end 

  def inspect
  end

  def find_all_by_merchant_id(merchant_id)
    @all_items.find_all { |item| item.merchant_id.eql?(merchant_id) }
  end

  def find_all_with_description(fragment)
    @all_items.find_all do |item|
      item.description.downcase.include?(fragment.downcase)
    end
  end

  def find_all_by_price_in_range(price_range)
    @all_items.find_all do |item|
      price_range.include?(item.unit_price.to_i)
    end
  end

  def find_all_by_price(price)
    @all_items.find_all { |item| item.unit_price.eql?(price) }
  end

  def find_by_name(name)
    @all_items.find do |item|
      item.name.downcase.eql?(name.downcase)
    end
  end

  def find_all_by_name(fragment)
    @all_items.find_all do |item|
      item.name.downcase.include?(fragment.downcase)
    end
  end

  def inspect 
    "#<#{self.class} #{@all.size} rows>"
  end

end
